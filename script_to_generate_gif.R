library(imager)
library(fs)
library(stringr)
library(animation)

imgs_paths <- fs::dir_ls('raw_imgs/')
imgs_paths

texts <- c('Pinones Beach (Vegetation Index):\nApril 08, 2017',
           'Pinones Beach (Original):\nApril 08, 2017',
           'Pinones Beach (Vegetation Index):\nOctober 20, 2017',
           'Pinones Beach (Vegetation Index):\nMay 13, 2018',
           'Pinones Beach (Vegetation Index):\nMay 13, 2019')


for (i in 1:5){
    image <- load.image(imgs_paths[i])
    new_image <- draw_text(image, 1000, 200, texts[i], 'white')

    new_file_name = paste0('new_imgs/', str_remove(imgs_paths[i], 'raw_imgs/'))
    save.image(im = new_image, file = new_file_name, quality = 2)
}


new_imgs_path <- fs::dir_ls('new_imgs/')
original_src <- new_imgs_path[2]
new_imgs_path[2] <- NA
new_imgs_path <- c(original_src, new_imgs_path)
new_imgs_path <- new_imgs_path[!is.na(new_imgs_path)]

saveGIF({
    for (idx in 1:5){
        image <- load.image(new_imgs_path[idx])

        plot(image, axes = F)
    }
}, interval = 0.5)
