# CMEE 2020 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Maddalena Cella"
preferred_name <- "Madda"
email <- "m.cella20@imperial.ac.uk"
username <- "MaddalenaCella"

# please remember *not* to clear the workspace here, or anywhere in this file. If you do, it'll wipe out your username information that you entered just above, and when you use this file as a 'toolbox' as intended it'll also wipe away everything you're doing outside of the toolbox.  For example, it would wipe away any automarking code that may be running and that would be annoying!

#my personal speciation rate
personal_speciation_rate<- 0.0038613

# Question 1
species_richness <- function(community){
rich<- length(unique(community))
return (rich)
}

# Question 2
init_community_max <- function(size){
max_comm<- seq(from=1, to=as.numeric(size)) 
return (max_comm) 
}

# Question 3
init_community_min <- function(size){
 min_comm <- rep(1, as.numeric(size))
 return (min_comm) 
}

# Question 4
choose_two <- function(max_value){
#set.seed(123)
rand<- sample(1:max_value, size=2, replace=FALSE)
return(rand)
}

# Question 5
neutral_step <- function(community){
pick<-choose_two(length(community))
die<- pick[1]
reproduce<- pick[2]
community_new<- replace(community, die, community[reproduce]) 
return(community_new)
}

# Question 6
neutral_generation <- function(community){
comm<- length(community)
if ((comm %%2 ) !=0) {
      round_down<- floor(comm/2)
      round_up<- ceiling(comm/2)
      up_down <- c(round_up, round_down)
      #set.seed(123)
      n_steps<-sample(up_down,1)}
if ((comm%%2)==0) {
   n_steps<- comm/2
}
community_new<- community
for(steps in 1:n_steps){
  new_comm<- neutral_step(community_new)
  community_new<- new_comm
}
return(community_new)
}

# Question 7
neutral_time_series <- function(community, duration)  {
time_series<- species_richness(community)
community_g<- community
for (g in 1:duration){
  gen<- neutral_generation(community)
  richness <- species_richness(gen)
  time_series <- c(time_series, richness)
  community_g<- gen
}  
return(time_series)
}

# Question 8
question_8 <- function() {
  # clear any existing graphs and plot your graph within the R window
  y <-neutral_time_series(community=init_community_max(100), duration=200)
  x <- seq(from=0, to=200, by=1)
  plot(x,y, type='p', ylim=c(0,100), col='red', pch=17, xlab='Number of generations', ylab="Species Richness")
  return("If you wait long enough, the system will always converge to a dynamic equilibrium 
  with an intermediate level of species richness.")#does it converge to monodominance???
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
pick<-choose_two(length(community))
die<- pick[1]
reproduce<- pick[2]

#set.seed(123)
sam<-sample(c(1, 2),1, prob= c((1-speciation_rate),speciation_rate))
    if (sam==1){
      community_new<- replace(community, die, community[reproduce])
    }
    if (sam==2){
      new_sp<- max(community)+1
      community_new<- replace(community, die, new_sp)
    }
return(community_new)  
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
comm<- length(community)
if ((comm %%2 ) !=0) {
      round_down<- floor(comm/2)
      round_up<- ceiling(comm/2)
      up_down <- c(round_up, round_down)
      set.seed(123)
      n_steps<-sample(up_down,1)}
if ((comm%%2)==0) {
   n_steps<- comm/2
}
community_new<- community
for(steps in 1:n_steps){
  new_comm<- neutral_step_speciation(community_new, speciation_rate)
  community_new<- new_comm
}
return(community_new)
}  


# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
time_series<- species_richness(community)
community_g<-community
for (g in 1:duration){
  gen<- neutral_generation_speciation(community_g, speciation_rate)
  richness <- species_richness(gen)
  time_series <- c(time_series, richness)
  community_g<- gen
}  
return(time_series) 
}

# Question 12
question_12 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  dev.off()
  y <-neutral_time_series_speciation(community=init_community_max(100), speciation_rate=0.1, duration=200)
  x <- seq(from=0, to=200, by=1)
  y1 <-neutral_time_series_speciation(community=init_community_min(100), speciation_rate=0.1, duration=200)
  x1 <- seq(from=0, to=200, by=1)
  
  plot(x1,y1, type='p', ylim=c(0,100), col='red', pch=17, xlab='Number of generations', ylab="Species Richness")
  points(x,y, pch=21, col= 'blue', type='p')
  legend('topright', legend=c("Maximum richness", "Mono-dominance"), col=c('blue','red'), pch=c(21,17), bty='o', text.col='black', title="Initial population state:")

  return("Initial conditions have a strong effect on the results of the simulation....")
}

# Question 13
species_abundance <- function(community)  {
freq_col<-as.data.frame(table(community))$Freq
abun_comm<- sort(freq_col, decreasing=TRUE)

return(abun_comm)
}

# Question 14
octaves <- function(abundance_vector) {

  #n<- (floor((log(max(abundance_vector)))/(log(2))))+1
  #n_octaves<- n+1
  log_abundance<- floor(((log(abundance_vector))/log(2)))+1
  #for (s in abundance_vector){
   # position<- floor((log(max(s)))/(log(2)))
    #actual_bin<-n+1
  
  octaves<-tabulate(log_abundance, 
  nbins=(floor((log(max(abundance_vector)))/(log(2))))+1)  
return(octaves)
}

# Question 15
sum_vect <- function(x, y) {
if(length(x)==length(y)){
  sum= x+y
} 
if(length(x) != length(y)){
  n<- max(length(x),length(y))
  length(x)<-n
  length(y)<-n
  x[is.na(x)]<-0
  y[is.na(y)]<-0
  sum=x+y
}

return(sum)
}


# Question 16 
question_16 <- function() {
  # clear any existing graphs and plot your graph within the R window
  dev.off()
  comm<- init_community_max(100)
  for(i in 1:200){ #run neutral model simulation for 200 gens
    y <-neutral_generation_speciation(community=comm, speciation_rate=0.1)
    comm<- y}

sp_ab<-species_abundance(y) #obtain abundance and octaves after 200 gens
oct<-octaves(sp_ab)

sao<- oct #empty vector that will contain sum octaves
  for(i in 1:2000){
    y <-neutral_generation_speciation(community=comm, speciation_rate=0.1)
    comm<- y
    if (i %% 20==0){ #every twenty record octave abundance
      sp_ab_i<-species_abundance(y)
      oct_i<-octaves(sp_ab_i)
      summ<- sum_vect(sao, oct_i)
      sao<- summ #mean octave abundance: sum divided by number of elements in the vector
    }
  }
avg_sao<- sao/(2000/20) #total sum/ number of times I did the addition

comm_min<- init_community_min(100)
  for(i in 1:200){ #run neutral model simulation for 200 gens
    y_min <-neutral_generation_speciation(community=comm_min, speciation_rate=0.1)
    #print(y)
    #x<- neutral_generation_speciation(community=y, speciation_rate=0.1)
    #print(x)
    comm_min<- y_min}

sp_ab_min<-species_abundance(y_min) #obtain abundance and octaves after 2000 gen
oct_min<-octaves(sp_ab_min)

sao_min<- oct_min #empty vector that will contain avg octaves
  for(i in 1:2000){
    y_min <-neutral_generation_speciation(community=comm_min, speciation_rate=0.1)
    comm_min<- y_min
    if (i %% 20==0){ #every twenty record octave abundance
      sp_ab_i_min<-species_abundance(y_min)
      oct_i_min<-octaves(sp_ab_i_min)
      sao_min<- sum_vect(sao_min, oct_i_min) #sum octave abundance
    }
  }
avg_sao_min<- sao_min/(2000/20)

df_sao <-rbind(avg_sao, avg_sao_min)

#barplot
x<-c('1', '2-3', '4-8', '9-16', '17-32', '33-64', '65-128')
z<-c(2,5,8,11,14,17,20)
barplot(df_sao, xlab='Abundance octave', ylab='Average number of species', ylim=c(0,10),
col= c('red','blue'), beside=TRUE, main='Mean species abundance distribution as octaves')
axis(1, at=z,labels=x)
legend('topright', c('Maximum initial richness', 'Initial monodominance'),
fill= c('red','blue'))

return("The initial condition of the system does not appear to matter. In fact, over time, both when starting with a maximum initial richness or with mono-dominance, 
the community will converge to a state where most species are rare, and very few are common.")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
# Start with a community with size given by the input size and minimal diversity.
# -Apply neutral generations with a speciation rate given by speciation_rate for a
# predefined amount of time wall_time measured in minutes. (Hint: if you’re not sure
# where to start get a timer working on its own first and use the proc.time command
# for this).
# i<- as.numeric(Sys.getenv('PBS_ARRAY_INDEX'))
# do_simulation(i)

#parameters of the function
p1<-speciation_rate
p2<-size
p3<-wall_time
p4<-interval_rich
p5<-interval_oct
p6<-burn_in_generations

#simulations start here
community_start<- init_community_min(size=size)
rich<- species_richness(community_start)
oct_v<- octaves(species_abundance(community_start))
oct<-list(oct_v)
i<-0
start_time<-proc.time()
repeat{ 
new_comm<- neutral_generation_speciation(community_start,speciation_rate)
community_start<-new_comm
i<-i+1
current_time<-proc.time()
    if (isTRUE(((current_time[3]-start_time[3])/60)>=wall_time)){break}
    if(i %% interval_rich==0 & i < burn_in_generations){
      new_rich<- species_richness(new_comm)
      rich<- rbind(rich, new_rich)}
    if(i%% interval_oct==0){
      sp_ab_new<-species_abundance(new_comm)
      oct_new<-octaves(sp_ab_new)
      oct<- append(oct, list(oct_new))    }

    }

save(rich, oct, new_comm, current_time, p1, p2, p3, p4, p5, p6, file= toString(output_file_name))
  
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {

file_names<-as.list(dir(pattern="res_[1-100]*"))
oct_500<- c(0,0,0,0)
oct_1000<- c(0,0,0,0)
oct_2500<- c(0,0,0,0)
oct_5000<- c(0,0,0,0)
 init_500<-0 #number of octaves above 80(=burn in generation)
 init_1000<-0
  init_2500<-0
  init_5000<-0

for (i in 1:length(file_names)){
  loaded_file<-load(file_names[[i]])
  if (length(oct)>80){
  oct_post_80<- oct[80:length(oct)] #change it to 80!!#the burn in finishes at 8*size and size oct are recorded every size/10, the burn in ends at the 80th oct recorded
  sum_post_80<- c(0,0,0,0)
    for (j in 1:length(oct_post_80)){
      sum_post_80<- sum_vect(oct_post_80[[j]], sum_post_80)}
      mean_post_80<- sum_post_80/(length(oct_post_80))
  if(p2==500){
    #oct_500<- #how do I know the first value i should average it with??
    oct_500<- sum_vect(oct_500, mean_post_80)
    init_500<-init_500+1}
  if(p2==1000){
    oct_1000<- sum_vect(oct_1000, mean_post_80)
    init_1000<-init_1000+1}
  if(p2==2500){
    oct_2500<- sum_vect(oct_2500, mean_post_80)
    init_2500<- init_2500+1}
  # if(p2==5000){
  #   oct_5000<- sum_vect(oct_5000, mean_post_80)
  #   init_5000<- init_5000+1}
  }
  if(length(oct)>25){
    oct_post_35<- oct[25:length(oct)] #relax burn-in for 5000 init pop
    sum_post_35<- c(0,0,0,0)
    for (k in 1:length(oct_post_35)){
      sum_post_35<- sum_vect(oct_post_35[[k]], sum_post_35)}
    mean_post_35<- sum_post_35/(length(oct_post_35))
    if(p2==5000){
      oct_5000<- sum_vect(oct_5000, mean_post_35)
      init_5000<-init_5000+1} 
  }}
mean_oct_500<- oct_500/init_500
mean_oct_1000<- oct_1000/init_1000
mean_oct_2500<-oct_2500/init_2500
mean_oct_5000<- oct_5000/init_5000 

combined_results <- list(mean_oct_500, mean_oct_1000, mean_oct_2500, mean_oct_5000)
save(combined_results, file="combined_results.rda")
}


plot_cluster_results <- function()  {
    # clear any existing graphs and plot your graph within the R window
    # load combined_results from your rda file
    # plot the graphs
  load('combined_results.rda')
  dev.off()
  par(oma=c(4,1,1,1), mfrow=c(2,2), mar=c(2,2,1,1))
  x<-c('1', '2-3', '4-8', '9-16', '17-32', '33-64', '65-128', '129-256', '257-512', '513-1024', '514-2048', '515-4096')
  z<-c(1:12)
  barplot(combined_results[[1]], xlab = 'Abundance octave',
          ylab='Avg number of species', ylim=c(0,3), col='blue')
  axis(1, at=z,labels=x)
  barplot(combined_results[[2]], xlab = 'Abundance octave',
          ylab='Avg number of species', ylim=c(0,5), col='red')
  axis(1, at=z,labels=x)
  barplot(combined_results[[3]], xlab = 'Abundance octave',
          ylab='Avg number of species', ylim=c(0,10), col='green')
  axis(1, at=z,labels=x)
  barplot(combined_results[[4]], xlab = 'Abundance octave',
          ylab='Avg number of species', ylim=c(0,20), col='orange')
  axis(1, at=z,labels=x)
  mtext("Mean species abundance octaves from the simulation runs", line=0, side=3, outer=TRUE, cex=1.2, font=1)
  par(fig=c(0,1,0,1), oma=c(0,0,0,0), mar=c(0,0,0,0), new=TRUE)
  plot(0,0, type='l', bty='n',xaxt='n',yaxt='n')
  legend('bottom', c('Initial pop size= 500', 'Initial pop size= 1000', 'Initial pop size= 2500', 'Initial pop size= 5000'), 
         fill= c('blue','red','green','orange'), xpd=FALSE, bty='n', ncol=2, text.font = 1, box.lty = 0)

  return(combined_results)
}

# Question 21
question_21 <- function()  {
  print(log(8)/log(3))
  return("this object is made out of 8 fractal objects and the scaling factor is 3. The fractal
  dimensions are therefore log(8)/log(3)")
}

# Question 22
question_22 <- function()  {
  print(log(20)/log(3))
  return("Cube dimensions of 3x3x3: so there are 27(3x3x3)-7(the empty cubes). This is equal to 20 
  blocks we need to find the fractal dimensions of. 3 is the scaling factor. To calculate the fractal dimensions
  I take the log of 20 divided by log 3.")
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  dev.off()
    A<- c(0,0)
    B<- c(3,4)
    C<- c(4,1)
    X<-c(0,0)

    start<-plot(c(0,3,4),c(0,4,1), axes=FALSE, ann=FALSE)
      points(x=X[1], y=X[2], cex=0.5)
    
    for(i in 1:10000){
      move_to<-sample(1:3,1)
      if (move_to==1){
        X<- sum_vect(X, A)/2
        add<-start+ points(x=X[1],y=X[2], cex=0.5)
        start<-add
      }
      if (move_to==2){
        X<- sum_vect(X, B)/2
        add<-start+ points(x=X[1],y=X[2], cex=0.5)
        start<-add
      }
      if (move_to==3){
        X<- sum_vect(X, C)/2
        add<-start+ points(x=X[1],y=X[2], cex=0.5)
        start<-add
      }
    }
  return('I see a fractal triangle (Sierpiński triangle) appearing.')
}

# Question 24
turtle <- function(start_position, direction, length)  {

x_direction <- length*(cos(direction))
y_direction <- length*(sin(direction))
move <- c(x_direction,y_direction)
end_position <- start_position + move


segments(start_position[1], start_position[2], end_position[1], end_position[2])

return(end_position) # you should return your endpoint here.
}


# Question 25
elbow <- function(start_position, direction, length)  {
 end_point<-turtle(start_position,direction,length)
 end_point_2<-turtle(start_position=end_point, direction=(direction- pi/4), length=length*0.95)

}

graphics.off()
plot.new()
plot.window(xlim = c(-10,10), ylim = c(-10,10))
# Question 26
spiral <- function(start_position, direction, length)  {
end_point<-turtle(start_position,direction,length)
if(length*0.95 > 0.01){
end_point_2<-spiral(start_position=end_point, direction=direction-pi/4, length=length*0.95)}
  return("I obtain a spiral with 45 degrees edges, adding an if statement ensures the recursive function stops calling itself over and over again.")
}

# Question 27
draw_spiral <- function()  {
  graphics.off()
  plot.new()#open new plot
  plot.window(xlim = c(-6,6), ylim = c(-6,6))
  spiral(c(2,-2), pi, 3.5) #plot the spiral
               
}
# Question 28
tree <- function(start_position, direction, length)  {
  end_point<-turtle(start_position,direction,length)
  if(length*0.65 > 0.01){
    end_point_2<-tree(start_position=end_point, direction=direction-pi/4, length=length*0.65)}
  if(length*0.65>0.01){
    end_point_2<-tree(start_position=end_point, direction=direction+pi/4, length=length*0.65)}
  }

draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot.new()#open new plot
  plot.window(xlim = c(-6,6), ylim = c(-6,6))
  tree(c(0,-5), pi/2, 3.5) #plot the spiral
}

# Question 29
fern <- function(start_position, direction, length)  {
  end_point<-turtle(start_position,direction,length)
  if(length*0.38 > 0.05){
    end_point_2<-fern(start_position=end_point, direction=direction+pi/4, length=length*0.38)}
  if(length*0.87>0.05){
    end_point_2<-fern(start_position=end_point, direction=direction, length=length*0.87)}  
}

draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot.new()#open new plot
  plot.window(xlim = c(-10,10), ylim = c(-10,10))
  fern(c(0,-10), pi/2, 2.7)  
}

# Question 30
fern2 <- function(start_position, direction, length, dir) {
  end_point<-turtle(start_position,direction,length)
  
  if(length*0.38 > 0.02 & dir %% 2 ==1){
    end_point_2<-fern2(start_position=end_point, direction=direction+ pi/4, length=length*0.38, dir = dir)}
  if (length*0.38 > 0.02 & dir %% 2 == 0){
    end_point_4<-fern2(start_position=end_point, direction=direction-pi/4, length=length*0.38, dir = dir)}
  if(length*0.87>0.02){
    end_point_3<-fern2(start_position= end_point, direction=direction, length=length*0.87, dir=dir+1)}  
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot.new()#open new plot
  plot.window(xlim = c(-7,7), ylim = c(-7,7))
  fern2(c(0,-7), pi/2, 1.7,1)
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window
#   You're on the right kind of track - but yes it is hard
# where does the 2.190 come from? - you should use qnorm function to figure it out 
  #- the 97.2% CI is not quite the same as the 97% one
#     There is another way, which is to store the sum of all the richnesses
#     and the sum of all the squares of the richnesses
#     then calculate the variance (and standard deviation) from those two numbers
#     that way you don't have to store the whole lot in one huge data frame
#   In general I'd say hand in any attempt you have and it won't harm you - it can only give a bonus!
#     
dev.off()
comm<- init_community_max(100)
richness<- species_richness(comm)
generation<- 0
sum_richness<- 0
sum_squares<- 0

for (k in 1:40){
  for(i in 1:2000){ 
    richness<- species_richness(comm)
    generation<- 0
    if (i%%50==0){
    y <-neutral_generation_speciation(community=comm, speciation_rate=0.1)
    rich<-species_richness(y)
    comm<- y
    richness<- rbind(richness, rich)
    generation<- rbind(generation, i)
    }
  }
  sum_richness<- sum_vect(sum_richness, richness)
  sum_squares<- sum((richness-mean(richness))^2)
}
mean_richness= sum_richness[2]/40
variance<- sum_squares/40
stnd_dev<- sqrt(variance)
conf_int<- qnorm(0.972, mean_richness, stnd_dev)

  # richness_plot<- 0
  # CI_upper_plot<- 0
  # CI_lower_plot<- 0
  # for (row in 1:nrow(add_richness)){
  #   mean_richness<- mean(add_richness[row,])
  #   richness_plot<-rbind(richness_plot, mean_richness)
  #   stnd_dev<- sd(add_richness[row,])
  #   CI_97_upper<- mean_richness + (2.190*stnd_dev/sqrt(length(add_richness[row,])))
  #   CI_97_lower<- -CI_97_upper
  #   CI_upper_plot<- rbind(CI_upper_plot, CI_97_upper)
  #   CI_lower_plot<-rbind(CI_lower_plot, CI_97_lower)}
  # critical_value<- 100-97.2=2.8<- alpha=0.028--> 0.028/2=0.014--> 1-0.014=0.986--> look it 
  # up in a table-->2.190 

  df_rich <-data.frame(generation, richness)
  plot(df_rich$generation, df_rich$richness, xlab='Generations', ylab='Species richness')

}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
    dev.off()
    A<- c(0,0)
    B<- c(3,4)
    C<- c(4,1)
    X<-c(11,-2)
    
    start<-plot(c(0,3,4),c(0,4,1), axes=FALSE, ann=FALSE)
    points(x=X[1], y=X[2], cex=0.5)
    
    for(i in 1:10000){
      move_to<-sample(1:3,1)
      if (move_to==1){
        X<- sum_vect(X, A)/2
        add<-start+ points(x=X[1],y=X[2], cex=0.5)
        start<-add
      }
      if (move_to==2){
        X<- sum_vect(X, B)/2
        add<-start+ points(x=X[1],y=X[2], cex=0.5)
        start<-add
      }
      if (move_to==3){
        X<- sum_vect(X, C)/2
        add<-start+ points(x=X[1],y=X[2], cex=0.5)
        start<-add
      }
    }
  return("No matter where the initial point X is located, after a certain number of steps
         the same fractal triangle will be produced.")
}

# Challenge question F
Challenge_F <- function() {
 new_turtle<- function(start_position, direction, length, colour, size){ 
   x_direction <- length*(cos(direction))
   y_direction <- length*(sin(direction))
   move <- c(x_direction,y_direction)
   end_position <- start_position + move
   segments(start_position[1], start_position[2], end_position[1], end_position[2], lwd=size,
            col=colour)
   return(end_position)}
new_fern2 <- function(start_position, direction, length, dir, colour, size) {
  end_point<-new_turtle(start_position,direction,length, colour, size)
  
  if(length*0.38 > 0.09 ){
    end_point_2<-new_fern2(start_position=end_point, direction=direction+ pi/4, length=length*0.38, dir = dir, colour='seagreen', size= size*0.9)}
  if (length*0.38 > 0.09 ){
    end_point_4<-new_fern2(start_position=end_point, direction=direction-pi/4, length=length*0.38, dir = dir, colour='seagreen', size=size*0.9)}
  if(length*0.87>0.09){
    end_point_3<-new_fern2(start_position= end_point, direction=direction, length=length*0.87, dir=dir+1, colour='seagreen', size=size*0.9)}  
}  
new_fern2_1 <- function(start_position, direction, length, dir, colour, size) {
  end_point<-new_turtle(start_position,direction,length, colour, size)
  
  if(length*0.38 > 0.007 ){
    end_point_2<-new_fern2_1(start_position=end_point, direction=direction+ pi/4, length=length*0.38, dir = dir, colour='seagreen', size= size*0.9)}
  if (length*0.38 > 0.007 ){
    end_point_4<-new_fern2_1(start_position=end_point, direction=direction-pi/4, length=length*0.38, dir = dir, colour='seagreen', size=size*0.9)}
  if(length*0.87>0.007){
    end_point_3<-new_fern2_1(start_position= end_point, direction=direction, length=length*0.87, dir=dir+1, colour='seagreen', size=size*0.9)}  
} 
new_fern3 <- function(start_position, direction, length, dir, colour, size) {
  end_point<-new_turtle(start_position,direction,length, colour, size)
  if(length*0.38 > 0.009 & dir %% 2 ==1){
    end_point_2<-new_fern3(start_position=end_point, direction=direction+ pi/4, length=length*0.38, dir = dir, colour='seagreen', size= size*0.9)}
  if (length*0.38 > 0.009 & dir %% 2 ==0){
    end_point_4<-new_fern3(start_position=end_point, direction=direction-pi/4, length=length*0.38, dir = dir, colour='seagreen', size=size*0.9)}
  if(length*0.87>0.009){
    end_point_3<-new_fern3(start_position= end_point, direction=direction, length=length*0.87, dir=dir+1, colour='seagreen', size=size*0.9)}  
} 
new_fern3_1 <- function(start_position, direction, length, dir, colour, size) {
  end_point<-new_turtle(start_position,direction,length, colour, size)
  if(length*0.38 > 0.1 & dir %% 2 ==1){
    end_point_2<-new_fern3_1(start_position=end_point, direction=direction+ pi/4, length=length*0.38, dir = dir, colour='seagreen', size= size*0.9)}
  if (length*0.38 > 0.1 & dir %% 2 ==0){
    end_point_4<-new_fern3_1(start_position=end_point, direction=direction-pi/4, length=length*0.38, dir = dir, colour='seagreen', size=size*0.9)}
  if(length*0.87>0.1){
    end_point_3<-new_fern3_1(start_position= end_point, direction=direction, length=length*0.87, dir=dir+1, colour='seagreen', size=size*0.9)}  
}  
    graphics.off()
    par(oma=c(1,1,2,2), mfrow=c(2,2), mar=c(1,1,2,2))
    plot.new()#open new plot
    plot.window(xlim = c(-7,7), ylim = c(-7,7))
    new_fern2_1(c(0,-7), pi/2, 2, 1, 'saddlebrown', 2)
    plot.new()
    plot.window(xlim = c(-7,7), ylim = c(-7,7))
    new_fern2(c(0,-7), pi/2, 2, 1, 'saddlebrown', 2)
    plot.new()
    plot.window(xlim = c(-7,7), ylim = c(-7,7))
    new_fern3(c(0,-7), pi/2, 2, 1, 'saddlebrown', 2)
    plot.new()
    plot.window(xlim = c(-7,7), ylim = c(-7,7))
    new_fern3_1(c(0,-7), pi/2, 2, 1, 'saddlebrown', 2)
    mtext("Firs and ferns with different line size thresholds", line=0, side=3, outer=TRUE, cex=1.2, font=0.8)

    return('As the line size threshold becomes smaller, the more dense the lines become and the more the script takes to run.
           Bigger values of the line size threshold correspond to more sparse lines and the script takes a shorter time to run.')  
  }
#   

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


