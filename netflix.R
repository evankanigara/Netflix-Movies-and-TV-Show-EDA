library(dplyr)
library(ggplot2)
library(tidyverse)
library(stringr)
library(plyr)

(.packages())

#Membaca data
df0<-read.csv("Data/netflix_titles.csv")
##Membuat data blank menjadi NA
df0[df0==""] <- NA
#Mengubah minute
df0b$duration=as.numeric(gsub(" min", "", df0$duration))
df0b<-df0
#Mengubah season
df0s<-df0
df0s$duration=as.numeric(gsub(" Season","",df0s$duration))
#Menguubah year added
dfyear<-df0
dfyear1<-str_sub(dfyear$date_added, start= -4)
dfyear3<-as.numeric(dfyear1)
dfyear$date_added<-dfyear3


##Variation Categorical
ggplot(data=df0)+
  geom_bar(mapping=aes(x=type),fill="darkblue")+
  xlab("Jenis Film")+
  ylab("Jumlah")+
  ggtitle("Film Netflix berdasarkan jenisnya")
#menghitung
dfjumlahmov=plyr::count(df0,'type')

#Variation Categorical
ggplot(data=subset(df0, !is.na(rating)),aes(x=rating))+
  geom_bar(stat="count",fill="darkblue")+
  xlab("Rating Film")+
  ylab("Jumlah")+
  ggtitle("Film Netflix berdasarkan Ratingnya")
#menghitung
dfjumlahrat=plyr::count(df0,'rating')

##Variation Continous Variable
ggplot(df0)+
  geom_histogram(mapping=aes(x=release_year,fill=rating),binwidth=3)+
  xlab("Tahun Rilis")+ylab("Jumlah")+
  ggtitle("Tahun Rilis Film")+labs(fill="Rating")

##Variation Continous Variable
ggplot(data=subset(df0b,!is.na(duration)),aes(x=duration))+
  geom_histogram(mapping=aes(x=duration,fill=rating),binwidth=3)+
  xlab("Durasi (Menit)")+ylab("Jumlah")+
  ggtitle("Durasi Film")+labs(fill="Rating")
summary(df0b$duration)

##COvariation Categorical vs Categorical
TilePlot=df0s %>%
  filter(duration==1)%>%
  count(rating,duration)%>%
  arrange(desc(n))
  ggplot(mapping=aes(x=duration,y=rating))+
  geom_tile((mapping=aes(fill=duration)))

  TilePlot=df0s %>%
    filter(df0s$duration==1)%>%
    count(rating,duration)%>%
    arrange(desc(n))%>%
  ggplot(data=subset(df0s,!is.na(duration), aes(duration, rating, fill = n))) + geom_raster()  
  ##oke berhasil
DurasiCount=df0s%>%
  filter(duration=="1")%>%
  count(rating,duration)%>%
  arrange(desc(n))
  
  ggplot(data=subset(DurasiCount,!is.na(rating)),mapping=aes(x=duration,y=rating))+
  geom_tile(mapping=aes(fill=n))
  
####INI YANG CATEGORICA YANG BERHASIL
df0s1<-df0
DurasiCount1=df0s1%>%
  filter(duration=="1 Season")%>%
  count(rating,duration)%>%
  arrange(desc(n))

ggplot(data=subset(DurasiCount1,!is.na(rating)),mapping=aes(x=duration,y=rating))+
  geom_tile(mapping=aes(fill=n))+
ggtitle("Rating Film Series")+ labs(fill = "Freq")+
  ylab('Rating')+xlab('Film berjenis Series')

###Categorical Date added
tile_date<-dfyear%>%
  count(rating,date_added)%>%
  arrange(desc(n))

ggplot(data=subset(tile_date,!is.na(rating)),mapping=aes(x=date_added,y=rating))+
  geom_tile(mapping=aes(fill=n))+
  ggtitle("Date Added by Rating")+ labs(fill = "Freq")+
  ylab('Rating')+xlab('Tahun ditambahkan')

##COVARIATION: Continous vs Continous
#Cleaning to movies
df0movies<-dfyear %>%
  select(type, title, date_added) %>%
  filter(type == "Movie")
df0moviescount=df0movies%>%
  filter(type=="Movie")%>%
  count(type,date_added)%>%
  arrange(desc(n))
df0moviescount=df0moviescount[-c(5),]
#menciptakangeomline
ggplot(data=subset(df0moviescount, !is.na(date_added)), aes(x=date_added, y=n, group=1)) +
  scale_x_continuous(breaks = seq(2008, 2019, by = 1))+
  geom_point()+
  geom_line()+
  ggtitle("Jumlah Film yang ditambahkan")+
  ylab('Jumlah')+xlab('Tahun')

#yang kedua tentang tv show
df0tvshow<-dfyear %>%
  select(type, title, date_added) %>%
  filter(type == "TV Show")
df0tvshowcount=df0tvshow%>%
  filter(type=="TV Show")%>%
  count(type,date_added)%>%
  arrange(desc(n))
df0tvshowcount=df0tvshowcount[-c(5,7),]
#menciptakangeomline
ggplot(data=subset(df0tvshowcount, !is.na(date_added)), aes(x=date_added, y=n, group=1)) +
  scale_x_continuous(breaks = seq(2008, 2019, by = 1))+
  geom_point()+
  geom_line()+
  ggtitle("Jumlah TV Series yang ditambahkan")+
  ylab('Jumlah')+xlab('Tahun')

##Covariation: Categorical vs Continous
#persiapan data
ggplot(data=subset(df0b,!is.na(rating),!is.na(duration))) + 
  geom_boxplot(mapping = aes(x=rating, y=duration))+ 
  scale_y_continuous(breaks = seq(0,800,100))+ 
  ggtitle('Distribusi Durasi tiap Rating')+ 
  xlab('Rating')+ theme_minimal()
stat.summary(dfboxplot)

##Membaca Geo-Box
df0G<-df0b %>%
  select(rating, duration) %>%
  filter(rating == "TV-MA")
df0G=subset(df0G,!is.na(duration))
summary(df0G$duration)
IQR(df0G$duration)
