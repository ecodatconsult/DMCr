#' Baut eine Verbindung zur FVA-Fotofallendatenbank auf (PostgreSQL).
#'
#' @param user character, legt den Benutzernamen auf der Datenbank fest, über den die Verbindung hergestellt werden soll
#' @param pw character, legt das Passwort des Benutzernamens auf der Datenbank fest, über den die Verbindung hergestellt werden soll
#' @param host character, Bezeichung der Adresse unter der die Datenbank erreichbar ist
#' @param port numeric, Port über dne die Datenbank erreichbar ist
#' @param db character, Name der Datenbank
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
