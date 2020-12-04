# Plot animtation
library(ggplot2)
library(gganimate)
library(data.table)

cent_dt <- fread("output/cent_df.csv")
setnames(cent_dt, c("0","1", "iter"), c("x", "y", "iteration"))
dt <- fread("output/df_labelled.csv")
setnames(dt, c("Cluster"), c("label"))

p <- ggplot() +
  geom_point(data=dt, aes(x=x, y=y, colour=factor(label)), alpha=0.5) +
  geom_point(
    data=cent_dt,
    aes(x=x,y=y,fill=factor(k)),
    colour="black",
    size=3,
    shape=24
  ) +
  transition_states(
    states = cent_dt$iter,
    transition_length = 2,
    state_length = 1
  ) +
  scale_fill_discrete(guide=F) +
  scale_colour_discrete(
    name="Cluster:"
  ) +
  theme_bw() +
  enter_fade() +
  ease_aes('sine-in-out') +
  shadow_trail(distance = 0.05)

anim_save("output/anim.gif",p, width = 600, height = 600)
