library(ggplot2)

x = runif(10, 0, 1)
y = as.factor(as.integer(10 * x))
d = data.frame(x = x, y = y)
ggplot(d, aes(theta = y, color = y, x = x, fill = y)) + coord_polar() + geom_bar()

