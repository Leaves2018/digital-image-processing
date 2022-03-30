import csv
import matplotlib.pyplot as plt
import matplotlib.image as mping
import numpy as np
from numpy import cos, arccos, sqrt, power, pi


# FUNCTION  RGB转HSI
# INPUT     RGB图像数据
# OUTPUT    uint8格式HSI图像数据
def rgb2hsi(rgb):
    # 如果没有归一化处理，则需要进行归一化处理（传入的是[0,255]范围值）
    if rgb.dtype.type == np.uint8:
        rgb = rgb.astype('float64')/255.0
    for i in range(rgb.shape[0]):
        for j in range(rgb.shape[1]):
            r, g, b = rgb[i, j, 0], rgb[i, j, 1], rgb[i, j, 2]
            # 计算h
            num = 0.5 * ((r-g)+(r-b))
            den = sqrt(power(r-g, 2)+(r-b)*(g-b))
            theta = arccos(num/den) if den != 0 else 0
            rgb[i, j, 0] = theta if b <= g else (2*pi-theta)
            # 计算s
            rgb[i, j, 1] = (1 - 3 * min([r, g, b]) / (r+g+b)) if r+g+b != 0 else 0
            # 计算i
            rgb[i, j, 2] = 1 / 3 * (r+g+b)
    return (rgb * 255).astype('uint8')


# FUNCTION  HSI转RGB
# INPUT     HSI图像数据
# OUTPUT    uint8格式RGB图像数据
def hsi2rgb(hsi):
    if hsi.dtype.type == np.uint8:
        hsi = (hsi).astype('float64') / 255.0
    for k in range(hsi.shape[0]):
        for j in range(hsi.shape[1]):
            h, s, i = hsi[k, j, 0], hsi[k, j, 1], hsi[k, j, 2]
            r, g, b = 0, 0, 0
            if 0 <= h < 2/3*pi:
                b = i * (1 - s)
                r = i * (1 + s * cos(h) / cos(pi/3-h))
                g = 3 * i - (b + r)
            elif 2/3*pi <= h < 4/3*pi:
                r = i * (1 - s)
                g = i * (1 + s * cos(h-2/3*pi) / cos(pi - h))
                b = 3 * i - (r + g)
            elif 4/3*pi <= h <= 5/3*pi:
                g = i * (1 - s)
                b = i * (1 + s * cos(h - 4/3*pi) / cos(5/3*pi - h))
                r = 3 * i - (g + b)
            hsi[k, j, 0], hsi[k, j, 1], hsi[k, j, 2] = r, g, b
    return (hsi * 255).astype('uint8')


# FUNCTION  绘制灰度直方图
# INPUT     图像数据、灰度直方图保存文件名
# OUTPUT    (灰度级，对应灰度级的频数)
def draw_grayscale_histogram(img, filename=''):
    # 给定的两幅图像jpg是uint8，png是float32
    # 如果传入的是png图像，需要转化为[0,255]
    if img.dtype.type != np.uint8:
        img = (img*255).astype(np.uint8)
    # 由于彩色图像的直方图均衡化是在亮度通道上进行，故暂认为灰度直方图也绘制在亮度通道上进行统计绘制
    arr = np.array([0]*256)
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            # H S I分别是0 1 2位置
            # 灰色PNG图像RGB三通道都一样，彩色图像转为HSI后取I通道
            arr[img[i, j, 2]] += 1
    ind = np.arange(256)
    plt.bar(ind, arr)
    filename = "_".join([filename, "grayscale", "histogram"])
    plt.title(filename)
    plt.savefig(filename+".png", dpi=72)
    plt.close()
    return ind, arr


# FUNCTION  直方图均衡化
# INPUT     图像数据
# OUTPUT    均衡化后的图像数据
def histogram_equalization(img, filename=''):
    # TODO 如何存储灰度JPG图像？
    is_jpg = False
    is_png = False
    # 如果输入图像是.jpg格式，需要转HSI
    if img.dtype.type == np.uint8:
        is_jpg = True
        img = rgb2hsi(img)
    # 如果输入图像是.png格式，为方便处理需要转[0,255]
    elif img.dtype.type != np.uint8:
        is_png = True
        img = (img*255).astype(np.uint8)
    # （1）统计$n_j$
    ind, n_j = draw_grayscale_histogram(img, filename)
    # （2）计算$P_f\left(f_j\right)=\frac{n_j}{n}$
    p_f = n_j / (img.shape[0]*img.shape[1])
    # （3）计算$C_\left(f\right)$
    # c = [p_f[i-1]+p_f[i] for i in range(1, len(p_f))]
    c = p_f
    for i in range(1, len(p_f)):
        c[i] += c[i-1]
    # （4）求$ \left \lfloor 255C\left(f\right)+0.5 \right \rfloor $
    g = [int(255*ele+0.5) for ele in c]
    # （5）计算$n_i$
    n_i = np.array([0]*len(n_j))
    for i in range(len(n_j)):
        n_i[g[i]] += n_j[i]
    # （6）计算$P_g\left(g_i\right)=\frac{n_i}{n}$
    p_g = n_i / (img.shape[0]*img.shape[1])
    # （7）映射关系$f_i\rightarrow g_i$
    plt.plot(ind, g, '-')
    plt.title('''Mapping relation: $f_i \\rightarrow g_i$''')
    plt.xlabel('''$f_i$''')
    plt.ylabel('''$g_i$''')
    plt.savefig('_'.join([filename, "mapping", "relation"]))
    plt.close()
    # 绘制直方图均衡化后的灰度直方图
    # 如果输入图像是.png格式，均衡化之前需要转化到[0,255]
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            for k in range(3):
                img[i, j, k] = g[img[i, j, k]]
    # 如果输入图像是.png格式，均衡化转换之后需要转化回[0,1]
    if is_png:
        img = (img/255).astype(np.float32)
    # 如果输入图像是.jpg格式，均衡化转换之后需要转换回RGB
    elif is_jpg:
        img = hsi2rgb(img)
    # 如果输入是.png，则输出也是".png"；如果输入是".jpg"，则输出也是".jpg"
    plt.imsave('_'.join([filename, "equalization"])+(".png" if is_png else ".jpg"), img)
    # 绘制直方图均衡化后的
    draw_grayscale_histogram(img, '_'.join([filename, "equalization"]))
    with open('_'.join([filename, "equalization"])+".csv", 'w+') as f:
        f_csv = csv.writer(f)
        f_csv.writerow(ind)
        f_csv.writerow(n_j)
        f_csv.writerow(c)
        f_csv.writerow(g)
        f_csv.writerow(n_i)
        f_csv.writerow(p_g)


# FUNCTION  直方图规格化
# INPUT     图像数据
# OUTPUT    规格化后的图像数据
def histogram_normalization(img):
    pass


# TODO matplotlib读取.png图像和.jpg图像表现不一样，考虑用除目前"打补丁"以外的方法解决
# FUNCTION  调用测试代码
if __name__ == '__main__':
    png = mping.imread('./grey.png').copy()
    histogram_equalization(png, 'grey')

    jpg = mping.imread('./color.jpg').copy()
    histogram_equalization(jpg, 'color')

    # 测试RGB转HSI和HSI转RGB
    # jpg = mping.imread('./color.jpg').copy()
    # hsi = rgb2hsi(jpg)
    # plt.imsave('./color_hsi.jpg', hsi)
    # jpg_recover = hsi2rgb(hsi)
    # plt.imsave('./color_recover.jpg', jpg_recover)

    # jpg = mping.imread('./color.jpg').copy()
    # hsi = rgb_hsi(jpg)
    # plt.imsave('./color_hsi.jpg', hsi)
    # jpg_recover = hsi_rgb(hsi)
    # plt.imsave('./color_recover.jpg', jpg_recover)
