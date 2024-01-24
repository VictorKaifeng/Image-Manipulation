using Images

#function to check a number is between 0 and 1
function check(a)
    if (a<0) 
        a = check(a+1)
    end
    if (a>1) 
        a = check(a-1)
    end
    return a
end

#blurr function
function blurr(rgb_image,con,divisor)
    #get size 
    n = size(rgb_image)
    #define blurr as 0
    blurr_red = 0
    blurr_blue = 0
    blurr_green = 0
    


    n_con = size(con)[1]
    #obtain radius of matrix
    p = Int64(floor(n_con/2))

    for i in 3:n[1]-(p+1)
        for j in 3:n[2]-(p+1)
            x = rgb_image[i,j]
            #rgb_image[i,j] = RGB(x.g^2,x.r^2,x.b^2)
            #convolution
            for k in -2:1:2
                for k2 in -2:1:2
                    blurr_red += rgb_image[i+k,j+k2].r * con[k+n_con-2][k2+n_con-p] /  divisor
                    blurr_green += rgb_image[i+k,j+k2].g * con[k+n_con-2][k2+n_con-p]/  divisor
                    blurr_blue += rgb_image[i+k,j+k2].b * con[k+n_con-2][k2+n_con-p]/  divisor
                end  
            end
            #check numbers are between 0 and 1
            blurr_blue = check(blurr_blue)
            blurr_green =check(blurr_green)
            blurr_red = check(blurr_red)
            #rewrite image
            rgb_image[i,j] = RGB(blurr_red,blurr_green,blurr_blue)
            #restart blurr
            blurr_red =0
            blurr_green =0
            blurr_blue =0
        end

    end
end

#load image
rgb_image = testimage("lighthouse")
#define convolution matrix
con = [
    [1,1,1,1,1],
    [1,1,1,1,1],
    [1,1,1,1,1],
    [1,1,1,1,1],
    [1,1,1,1,1] ]
#define inverse weight
divisor = 25.5
#compute blurr this will modify the existing rgb_image
blurr(rgb_image,con,divisor)

#repeat with another image
con = [
    [1,1,1,1,1],
    [1,-1,-1,-1,1],
    [1,-1,2,-1,1],
    [1,-1,-1,-1,1],
    [1,-1,-1,-1,1] ]
divisor = 10    
rgb_image2 = testimage("lighthouse")
rgb_image2 = load("palmera.jpg")
blurr(rgb_image2,con,divisor)
#check in a mossaic view the difference between blurs
mosaicview(testimage("lighthouse"),rgb_image2,rgb_image,ncol=3)
