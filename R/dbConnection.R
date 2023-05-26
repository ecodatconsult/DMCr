#' Baut eine Verbindung zur FVA-Fotofallendatenbank auf (PostgreSQL).
#'
#' @param type Bestimmt welche Art Verbindung hergestellt werden soll, ob nur Lese- oder auch Schreibrechte: type = c("read","write").
#'
#' @return Formal class PostgreSQLConnection
#' @export
#'
#' @examples
#'
dbConnection <- function(type){

  require(RPostgreSQL)
  require(DBI)

  if(type == "read"){
    psw = "fotofalle"
  }
  if(type == "write"){
    psw = "fotofalle"
  }

  con <- dbConnect("PostgreSQL"
                   , user = "anja"
                   , password = psw
                   , host = "FVAFR-PC52098v"
                   , port = 5432
                   , dbname = "fotofallen"
  )

  if(exists("con")){
    assign("con",con, envir = .GlobalEnv)
  }else{
    #stop("Verbindung zur Datenbank konnte nicht hergesellt werden", call. = TRUE, domain = NULL)
  }

}
