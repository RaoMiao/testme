using GameFramework.DataTable;
using System.Collections.Generic;

namespace MiniJY
{
    /// <summary>
    /// 功夫表。
    /// </summary>
    public class DRKongfu : IDataRow
    {

        /// <summary>
        /// 编号。
        /// </summary>
        public int Id
        {
            get;
            protected set;
        }

        /// <summary>
        /// 名称。
        /// </summary>
        public string Name
        {
            get;
            private set;
        }

        /// <summary>
        /// 武器。
        /// </summary>
        public string Weapon
        {
            get;
            private set;
        }

        /// <summary>
        /// NotUse 不是很懂
        /// </summary>
        public string Desc
        {
            get;
            private set;
        }

        /// <summary>
        /// 类型。
        /// </summary>
        public int Type
        {
            get;
            private set;
        }

        /// <summary>
        /// 类型说明。
        /// </summary>
        public string TypeDesc
        {
            get;
            private set;
        }

        /// <summary>
        /// 等级。
        /// </summary>
        public int Level
        {
            get;
            private set;
        }

        /// <summary>
        /// AP。
        /// </summary>
        public int Ap
        {
            get;
            private set;
        }

        /// <summary>
        /// DP。
        /// </summary>
        public int Dp
        {
            get;
            private set;
        }

        /// <summary>
        /// PP。
        /// </summary>
        public int Pp
        {
            get;
            private set;
        }

        /// <summary>
        /// 伤害。
        /// </summary>
        public int Damage
        {
            get;
            private set;
        }

        /// <summary>
        /// sum。
        /// </summary>
        public int Sum
        {
            get;
            private set;
        }

        /// <summary>
        /// Difficulty。
        /// </summary>
        public int Difficulty
        {
            get;
            private set;
        }

        /// <summary>
        /// Sound。
        /// </summary>
        public int Sound
        {
            get;
            private set;
        }

        /// <summary>
        /// Hp。
        /// </summary>
        public int Hp
        {
            get;
            private set;
        }

        /// <summary>
        /// Mp。
        /// </summary>
        public int Mp
        {
            get;
            private set;
        }

        /// <summary>
        /// Damage2。
        /// </summary>
        public int Damage2
        {
            get;
            private set;
        }

        /// <summary>
        /// Hit。
        /// </summary>
        public int Hit
        {
            get;
            private set;
        }

        /// <summary>
        /// Block。
        /// </summary>
        public int Block
        {
            get;
            private set;
        }


        /// <summary>
        /// Dodge。
        /// </summary>
        public int Dodge
        {
            get;
            private set;
        }

        /// <summary>
        /// Sex。
        /// </summary>
        public int Sex
        {
            get;
            private set;
        }

        /// <summary>
        /// Dream。
        /// </summary>
        public int Dream
        {
            get;
            private set;
        }


        /// <summary>
        /// StudyAni。
        /// </summary>
        public int StudyAni
        {
            get;
            private set;
        }

        /// <summary>
        /// MpCost。
        /// </summary>
        public int MpCost
        {
            get;
            private set;
        }

        /// <summary>
        /// Critical。
        /// </summary>
        public int Critical
        {
            get;
            private set;
        }

        public void ParseDataRow(string dataRowText)
        {
            string[] text = DataTableExtension.SplitDataRow(dataRowText);
            int index = 0;
            index++;
            Id = int.Parse(text[index++]);
            Name = text[index++];
            Weapon = text[index++];
            Desc = text[index++];
            Type = int.Parse(text[index++]);
            TypeDesc = text[index++];
            Level = int.Parse(text[index++]);
            Ap = int.Parse(text[index++]);
            Dp = int.Parse(text[index++]);
            Pp = int.Parse(text[index++]);
            Damage = int.Parse(text[index++]);
            Sum = int.Parse(text[index++]);
            Difficulty = int.Parse(text[index++]);
            Sound = int.Parse(text[index++]);
            Hp = int.Parse(text[index++]);
            Mp = int.Parse(text[index++]);
            Damage2 = int.Parse(text[index++]);
            Hit = int.Parse(text[index++]);
            Block = int.Parse(text[index++]);
            Dodge = int.Parse(text[index++]);
            index++;
            index++;
            index++;
            index++;
            Sex = int.Parse(text[index++]);
            Dream = int.Parse(text[index++]);
            StudyAni = int.Parse(text[index++]);
            MpCost = int.Parse(text[index++]);
            Critical = int.Parse(text[index++]);
        }
    }
}
