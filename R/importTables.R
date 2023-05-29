#' Lädt alle Tabellen einer Session und vereinigt sie zu einer großen Tabelle. Die Tabellen entstammen der Klassifikation mit dem Programm FFM2 und liegen im csv-Format vor.
#'
#' @param file_path Pfad zum Ordner der Session. Beispielsweise "N:/Projekte/Gruenbrueckenmonitor_1708/Daten/Feldarbeit/Fotofallenmonitoring/session_07".
#' @param data Bestimmt welche Tabellen geladen werden sollen: data = c("daten","ereignis"). Default = "both" lädt sowohl die _daten als auch die _ereignis Tabellen.
#'
#' @return data.table/data.frame
#' @export
#'
#' @examples
#'
importTables <- function(file_path, data) {

  require(dplyr)
  require(data.table)
  require(stringr)

  #file_path = "N:/Projekte/Forschungscluster_1768/02_Projektmodule/01_Kamerafallenthemen/AutomatisierteKlassifizierung/Daten/Fuchsprojekt_Lino/Spring2017"

  #decide which "data"
  data_both = c("daten","ereignis")

  if(data != "both" && length(data) == 1){
    i <- which(data_both == data)
  }
  if(data == "both"){
    data <- data_both
  }
  rm(data_both)

  for(i in 1:length(data)){

    #catch the names of all files
    filenames <- list.files(path = file_path,
                            recursive=T,
                            pattern= paste("^_",data[i],".csv",sep = ""),
                            full.names = TRUE)
    # Anja: Das Scannen der Ordner nach den Exceldateien kann sehr lange dauern. Daher habe ich das zweite Scannen abgekürzt, indem ich bei den filenames "ereignisse" und "daten" tausche. Es lässt sich in deiner Version nicht direkt implementieren. In der nächsten Zeile findest du den Code-Schnipsel, falls du es nutzen möchtest.
    # filenames <- str_replace(filenames, "_ereignis.csv", "_daten.csv" )

    if(length(filenames) >0){

      #load the files and bind them together
      table <-
        do.call(rbind,
                c(lapply(filenames,
                         function(x) {
                           d <- fread(x, encoding = "UTF-8")
                           # Anja: die drei Zeilen unten können raus.Dafür habe ich den Ordnerpfad und den Ordnernamen bei beiden Tabellen mit aufgenommen, da es immer wieder vorgekommen ist, dass diese nach dem Start com FFM2 aktualisiert worden sind.
                           # if (nchar(d$ORDNER[1]) == 20) {
                           #   d$ORDNER <- tail(unlist(str_split(x, pattern = "/")), 2)[1]
                           #}
                           d <- cbind(d,
                                      "standort_id_folder" = tail(unlist(str_split(x, pattern = "/")), 2)[1],
                                      "folder" = rep(str_remove(x, paste("/_",data[i],".csv",sep = "")), nrow(d)))
                           return(d)}
                ), fill = TRUE))

      #correct column name
      colnames(table)[1] <- "s_foto_id"

      #name the table after "data" = ereignis or daten
      assign(data[i],table, envir = .GlobalEnv)

      rm(filenames,table)
    }

  }

rm(i)

}
