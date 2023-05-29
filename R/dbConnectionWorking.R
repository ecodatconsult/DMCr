#' Eine Probe-Verbindung zur FVA-Fotofallendatenbank mit Schreibrechten, um das Passwort zu überprüfen.
#'
#'
#' @return Formal class PostgreSQLConnection
#' @export
#'
#' @examples
#'
#'
dbConnectionWorking <- function(psw){
  psw = "test"

  tryCatch(
    con_check <- with(read.csv(system.file("db_login.csv", package = "DMCr")),{
      DBI::dbConnect(RPostgreSQL::PostgreSQL(),
                     user = "postgres",
                     password = psw,
                     host = host,
                     port = port,
                     dbname = db)
    })

  , error=function(e) {})

  if(exists("con_check")) DBI::dbDisconnect(con_check)
  # TODO: remove assign and only return exists("con") i.e. TRUE/FALSE (close test connection)

  return(exists("con_check"))
}

