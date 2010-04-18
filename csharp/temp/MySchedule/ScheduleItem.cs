using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MySchedule
{
    abstract class ScheduleItem
    {
        protected DateTime startDateTime, endDateTime;
        private string subject;
        private string contents;
        protected string itemall;

        public string Subject {
            get {
                return subject;
            }
        }
        public string Contents {
            get {
                return contents;
            }
        }
        public string Itemall {
            get {
                return itemall;
            }
        }
        //開始日付時刻取得プロパティ
        public DateTime StartDateTime {
            get {
                return startDateTime;
            }
        }
        //終了日付時刻取得プロパティ
        public DateTime EndDateTime {
            get {
                return endDateTime;
            }
        }
        
        public ScheduleItem(string subject, string contents) {
            this.subject = subject;
            this.contents = contents;
        }

        public abstract string[] GetField();
    }

    class ShortItem : ScheduleItem 
    {
        public ShortItem(string sdate, string start, string end, 
            string subject, string contents) : base(subject, contents)
        {
            startDateTime = DateTime.Parse(sdate + " " + start);
            endDateTime = DateTime.Parse(sdate + " " + end);
            itemall = start + "～" + end + " " + subject + ":" + contents;
        }
        public override string[] GetField()
        {
            string[] field = new string[3];
            field[0] = string.Format("{0:yyyy/MM/dd}",startDateTime);
            field[1] = string.Format("{0:HH:mm}",startDateTime);
            field[2] = string.Format("{0:HH:mm}",endDateTime);
            return field;
        }
    }

    class LongItem : ScheduleItem
    {
        public LongItem(string sdate, string edate, string subject, string contents)
            : base(subject, contents)
        {
            startDateTime = DateTime.Parse(sdate);
            endDateTime = DateTime.Parse(sdate);
            itemall = sdate.Substring(5) + "～" + edate.Substring(5) +
                " " + subject + ":" + contents;
        }
        public override string[] GetField()
        {
            string[] field = new string[2];
            field[0] = string.Format("{0:yyyy/MM/dd}", startDateTime);
            field[1] = string.Format("{0:yyyy/MM/dd}", endDateTime);
            return field;
        }
    }
}
