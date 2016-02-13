#!/usr/bin/env ruby

require "jdbc/mysql"

Jdbc::MySQL.load_driver
Java::com.mysql.jdbc.Driver
$userurl = "jdbc:mysql://xxxxxxxxxx.com:3306/XBO"

class HostCheck
  def get_dns(service, env)
    connSelect = java.sql.DriverManager.get_connection($userurl, "xxxxx", "xxxxx")
    stmtSelect = connSelect.create_statement

    selectquery = "select dns from Nodes where service_name = \"#{service}\" and environment_name = \"#{env}\""
    rsS = stmtSelect.execute_query(selectquery)

    a = Array.new
    while (rsS.next) do
      a << rsS.getObject("dns")
    end 
    stmtSelect.close
    connSelect.close
    return a
  end

  def get_excluded_props
    connSelect = java.sql.DriverManager.get_connection($userurl, "xxxxx", "xxxxx")
    stmtSelect = connSelect.create_statement

    selectquery = "select * from Excluded_Props"
    rsS = stmtSelect.execute_query(selectquery)

    a = Array.new
    while (rsS.next) do
      a << rsS.getObject("property")
    end
    stmtSelect.close
    connSelect.close
    return a
  end

  def get_port(service)
    connSelect = java.sql.DriverManager.get_connection($userurl, "xxxxx", "xxxxx")
    stmtSelect = connSelect.create_statement

    selectquery = "select jmx_port from Services where name = \"#{service}\""
    rsS = stmtSelect.execute_query(selectquery)

    while (rsS.next) do
      a = rsS.getObject("jmx_port")
    end
    stmtSelect.close
    connSelect.close
    return a
  end

  def insert_excluded_prop(prop)
    connInsert = java.sql.DriverManager.get_connection($userurl, "xxxxx", "xxxxx")
    stmtInsert = connInsert.create_statement

    insertquery = "INSERT INTO Excluded_Props (property) VALUES (\"#{prop}\")"
    rsI = stmtInsert.execute_update(insertquery)

    stmtInsert.close
    connInsert.close
    return rsI
  end

  def delete_excluded_prop(prop)
    connDelete = java.sql.DriverManager.get_connection($userurl, "xxxxx", "xxxxx")
    stmtDelete = connDelete.create_statement

    deletequery = "DELETE FROM Excluded_Props WHERE property = \"#{prop}\""
    rsD = stmtDelete.execute_update(deletequery)

    stmtDelete.close
    connDelete.close
    return rsD
  end

  def get_services
    connSelect = java.sql.DriverManager.get_connection($userurl, "xxxxx", "xxxxx")
    stmtSelect = connSelect.create_statement

    selectquery = "select name from Services"
    rsS = stmtSelect.execute_query(selectquery)

    a = Array.new
    while (rsS.next) do
      a << rsS.getObject("name")
    end
    stmtSelect.close
    connSelect.close
    return a
  end
end
