#' Eine Probe-Verbindung zur FVA-Fotofallendatenbank mit Schreibrechten, um das Passwort zu überprüfen.
#'
#' @param user character, legt den Benutzernamen auf der Datenbank fest, über den die Verbindung hergestellt werden soll
#' @param psw character, legt das Passwort des Benutzernamens auf der Datenbank fest, über den die Verbindung hergestellt werden soll
#' @param host character, Bezeichung der Adresse unter der die Datenbank erreichbar ist
#' @param port numeric, Port über dne die Datenbank erreichbar ist
#' @param db character, Name der Datenbank
#'
#' @return Formal class PostgreSQLConnection
#' @export
#'
#' @examples
#'
dbConnectionUpload <- function(user = "anja", psw = "fotofalle", host = "FVAFR-PC52098v", port = 5432, db = "fotofallen"){

  require(RPostgreSQL)
  require(DBI)

  if(exists("con")){
    dbDisconnect(con)
    rm(con, envir = .GlobalEnv)
  }

  tryCatch(
  con <-  con <- dbConnect("PostgreSQL"
                           , user = user
                           , password = pw
                           , host = host
                           , port = port
                           , dbname = db
  )
  , error=function(e) {})

  if(exists("con")){
    con_list1 <- dbListTables(con)
    assign("con_list",con_list1, envir = .GlobalEnv)
    dbDisconnect(con)
    rm(con, con_list1, psw)
  }else{
    con_list1 <- "No"
    assign("con_list",con_list1, envir = .GlobalEnv)
    rm(con_list1)
  }
}
