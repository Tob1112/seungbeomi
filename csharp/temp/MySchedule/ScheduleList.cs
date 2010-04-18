using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MySchedule
{
    class ScheduleList
    {
        private List<ShortItem> shortitems;
        private List<LongItem> longitems;

        public ScheduleList() 
        { 
            shortitems = new List<ShortItem>();
            longitems = new List<LongItem>();
        }
               //その日のリストに予定を登録
        public bool AddShortitems(ShortItem sitem)
        {
            if (FindShortitem(sitem))
            {
                shortitems.Add(sitem);
                return true;
            }
            return false;
        }
        //その日のリストから予定を削除
        public void DeleteShortitems(int index)
        {
            shortitems.RemoveAt(index);
        }
        //その日のリストから予定を取得
        public ShortItem SelectShortitems(int index)
        {
            int loop = 0;
            foreach (ShortItem sitem in shortitems)
            { 
                if (loop == index) return sitem;
                loop++;
            }
            return null;
        }
              //一致しているデータがないときに登録
        public bool FindShortitem(ShortItem sitem)
        { 
            foreach (ShortItem sitem2 in shortitems)
            {
                if (sitem2.Itemall == sitem.Itemall)
                    return false;
            }
            return true;
        }
              //長期のリストに予定を登録
        public bool AddLongitems(LongItem litem)
        { 
            if (FindLongitem(litem)) 
            {
                longitems.Add(litem);
                return true;
            }
            return false;
        }
        //長期のリストから予定を削除
        public void DeleteLongitems(int index)
        {
            longitems.RemoveAt(index);
        }
        //長期のリストから予定を取得
        public LongItem SelectLongitems(int index)
        {
            int loop = 0;
            foreach (LongItem litem in longitems)
            {
                if (loop == index) return litem;
                loop++;
            }
            return null;
        }
              //一致しているデータがないときに登録
        public bool FindLongitem(LongItem litem)
        { 
            foreach (LongItem litem2 in longitems) 
            {
                if (litem2.Itemall == litem.Itemall) return false;
            }
            return true;
        }
        //その日のリストオブジェクトプロパティ
        public List<ShortItem> Shortitems
        {
            get {
                return shortitems;
            }
        }
        //長期のリストオブジェクトプロパティ
        public List<LongItem> Longitems
        {
            get
            {
                return longitems;
            }
        }
    }
}
