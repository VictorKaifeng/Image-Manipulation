using Plots,DelimitedFiles
function leerdatosnd(nombre; max=1000, unique= 0 )
    #Lee datos de la forma a b en una matriz, 
    # estableze el maximo de puntos a leer y hace check de si estan repetidos
    dat = readdlm(nombre,  Float64)
    n=size(dat)
    points =NTuple{n[2],Float64}[]
    point = zeros(n[2])
    m=min(n[1],max)
    for  i in 1:m
       k=0
        for j in 1:n[2] 
            point[j]=dat[i, j]
        end
        point2=Tuple(Float64(x) for x in point)
        push!(points,point2)
    
    end
    return points
  end

A=NTuple{2,Float64}[]
A= leerdatosnd("cartas.txt")
xpos=0.5
ypos = 1.5
#n equals number of cards
n=20
B=zeros(Int64,n)
plt2 = []

for i in 1:n

    B[i]=i*(-1)^(i)

    k=round((rand()*i*(-1)^(abs(rand(Int)))+rand()).%10,digits=2)

    Z=round(round(B[i]^n %200,digits=3)+k,digits =3)

    aux = plot(A,size=(1200, 1200),axis=([], false),label=:false, color=:black)
    aux = annotate!(xpos, ypos, text(Z   , :black, :center, 10     ))
    push!(plt2,aux)
end

#savefig(plot(plt2..., fmt=:pdf), "cartasblank2.pdf")
plot(plt2...)