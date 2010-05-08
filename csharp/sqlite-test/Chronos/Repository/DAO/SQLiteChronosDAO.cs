using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SQLite;

using Chronos.Domain;

namespace Chronos.Repository.DAO
{
    public sealed class SQLiteChronosDAO : IChronosDAO
    {
        private IDbConnection connection;

        public SQLiteChronosDAO(IDbConnection connection)
        {
            this.connection = connection;
        }

        public List<ChronosDTO> Select()
        {
            string sql = "SELECT USERID, NAME FROM CHRONOS";
            IDbCommand command = connection.CreateCommand();
            command.CommandText = sql;

            List<ChronosDTO> dtoList = new List<ChronosDTO>();

            using (IDataReader reader = command.ExecuteReader())
            { 
                while(reader.Read())
                {
                    ChronosDTO dto = new ChronosDTO();
                    dto.userId = (string) reader[0];
                    dto.name = (string)reader[1];
                    System.Console.WriteLine("data : userId:" + dto.userId + ", name - " + dto.name );
                    dtoList.Add(dto);
                }
            }
            return dtoList;
        }
    }
}
