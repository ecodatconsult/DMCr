#' Baut eine Verbindung zur FVA-Fotofallendatenbank auf (PostgreSQL).
#'
#' @param type Bestimmt welche Art Verbindung hergestellt werden soll, ob nur Lese- oder auch Schreibrechte: type = c("read","write").
#'
#' @return Formal class PostgreSQLConnection
#' @export
#'
#' @examples
#'
dbConnection <- function(type, user = "anja", pw = "fotofalle", host = "FVAFR-PC52098v", port = 5432, db = "fotofallen"){

  require(RPostgreSQL)
  require(DBI)

  if(type == "read"){
    psw = "fotofalle"
  }
  if(type == "write"){
    psw = "fotofalle"
  }

  con <- dbConnect("PostgreSQL"
                   , user = user
                   , password = pw
                   , host = host
                   , port = port
                   , dbname = db
  )

  if(exists("con")){
    assign("con",con, envir = .GlobalEnv)
  }else{
    #stop("Verbindung zur Datenbank konnte nicht hergesellt werden", call. = TRUE, domain = NULL)
  }

}
