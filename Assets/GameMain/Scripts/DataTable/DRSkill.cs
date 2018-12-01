using GameFramework.DataTable;
using System.Collections.Generic;

namespace MiniJY
{
    /// <summary>
    /// 技能表。
    /// </summary>
    public class DRSkill : IDataRow
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
        /// 类型。
        /// </summary>
        public string Type
        {
            get;
            private set;
        }

        /// <summary>
        /// 子类型。
        /// </summary>
        public string SubType
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
            protected set;
        }

        /// <summary>
        /// 性别。
        /// </summary>
        public int Sex
        {
            get;
            protected set;
        }

        /// <summary>
        /// 等级1。
        /// </summary>
        public int Level1
        {
            get;
            protected set;
        }

        /// <summary>
        /// 等级2。
        /// </summary>
        public int Level2
        {
            get;
            protected set;
        }

        /// <summary>
        /// AP。
        /// </summary>
        public int Ap
        {
            get;
            protected set;
        }

        /// <summary>
        /// Damage。
        /// </summary>
        public int Damage
        {
            get;
            protected set;
        }

        /// <summary>
        /// VsDP。
        /// </summary>
        public int VsDP
        {
            get;
            protected set;
        }

        /// <summary>
        /// VsPP。
        /// </summary>
        public int VsPP
        {
            get;
            protected set;
        }

        private const int MAXNEEDWUGONG = 5; // 进度
        private int[] m_Wugong = new int[MAXNEEDWUGONG];

        public int GetWugong(int index)
        {
            return index < m_Wugong.Length ? m_Wugong[index] : 0;
        }

        private int[] m_JiWugong = new int[MAXNEEDWUGONG];

        public int GetJiWugong(int index)
        {
            return index < m_JiWugong.Length ? m_JiWugong[index] : 0;
        }

        /// <summary>
        /// Beiyong。
        /// </summary>
        public int Beiyong
        {
            get;
            protected set;
        }

        /// <summary>
        /// Desc。
        /// </summary>
        public string Desc
        {
            get;
            protected set;
        }

        public void ParseDataRow(string dataRowText)
        {
            string[] text = DataTableExtension.SplitDataRow(dataRowText);
            int index = 0;
            index++;
            Id = int.Parse(text[index++]);
            Name = text[index++];
            Type = text[index++];
            SubType = text[index++];
            Level = int.Parse(text[index++]);
            Sex = int.Parse(text[index++]);
            Level1 = int.Parse(text[index++]);
            Level2 = int.Parse(text[index++]);
            Ap = int.Parse(text[index++]);
            Damage = int.Parse(text[index++]);
            VsDP = int.Parse(text[index++]);
            VsPP = int.Parse(text[index++]);
            for(int i = 0; i < MAXNEEDWUGONG; i++)
            {
                m_Wugong[i] = int.Parse(text[index++]);
            }

            for (int i = 0; i < MAXNEEDWUGONG; i++)
            {
                m_JiWugong[i] = int.Parse(text[index++]);
            }
            Beiyong = int.Parse(text[index++]);
            Desc = text[index++];
        }


    }
}
