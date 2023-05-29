checkFoldernames <- function(daten_ereignis_list_proc){

  falsche_ordnernamen_df <- unique(daten_ereignis_list_proc$daten[standort_id != standort_id_folder, .(standort_id,standort_id_folder),])

  if(nrow(falsche_ordnernamen_df) > 0){
    print("Die Ordnernamen folgender Standorte werden korrigiert: ")
    print(falsche_ordnernamen_df$standort_id_folder)
  }

  c(lapply(daten_ereignis_list_proc, function(data){
    data[standort_id_folder != standort_id,
         ':='(ordner = falsche_ordnernamen$standort_id_folder[i],
              standort_id = falsche_ordnernamen$standort_id_folder[i])
         ,]
  }),
  falsche_ordnernamen_df)

}
