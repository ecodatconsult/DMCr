#' Eine Probe-Verbindung zur FVA-Fotofallendatenbank mit Schreibrechten, um das Passwort zu überprüfen.
#'
#' @param psw Passwort für den Zugriff auf die FVA-Fotofallendatenbank mit Schreibrechten.
#'
#' @return Formal class PostgreSQLConnection
#' @export
#'
#' @examples
#'
dbConnectionUpload <- function(psw){

  require(RPostgreSQL)
  require(DBI)

  if(exists("con")){
    dbDisconnect(con)
    rm(con, envir = .GlobalEnv)
  }

  tryCatch(
  con <- dbConnect("PostgreSQL"
                   , user = "anja"
                   , password = psw
                   , host = "FVAFR-PC52098v"
                   , port = 5432
                   , dbname = "fotofallen"
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
