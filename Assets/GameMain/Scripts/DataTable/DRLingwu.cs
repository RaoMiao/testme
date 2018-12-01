using GameFramework.DataTable;
using System.Collections.Generic;

namespace MiniJY
{
    /// <summary>
    /// 领悟表。
    /// </summary>
    public class DRLingwu : IDataRow
    {
        private const int MaxPrevKongfuCount = 7; // 最大武器数量
        private int[] m_PrevKongfu = new int[MaxPrevKongfuCount];
        private int[] m_PrevKongfuLevel = new int[MaxPrevKongfuCount];

        /// <summary>
        /// Id。
        /// </summary>
        public int Id
        {
            get;
            protected set;
        }

        /// <summary>
        /// 武功Id。
        /// </summary>
        public int KongfuId
        {
            get;
            protected set;
        }

        public int GetPrevKongfu(int index)
        {
            return index < m_PrevKongfu.Length ? m_PrevKongfu[index] : 0;
        }

        public int GetPrevKongfuLevel(int index)
        {
            return index < m_PrevKongfuLevel.Length ? m_PrevKongfuLevel[index] : 0;
        }

        public void ParseDataRow(string dataRowText)
        {
            string[] text = DataTableExtension.SplitDataRow(dataRowText);
            int index = 0;
            index++;
            Id = int.Parse(text[index++]);
            KongfuId = int.Parse(text[index++]);
            for(int i = 0; i < MaxPrevKongfuCount; ++i)
            {
                m_PrevKongfu[i] = int.Parse(text[index++]);
            }

            for (int i = 0; i < MaxPrevKongfuCount; ++i)
            {
                m_PrevKongfuLevel[i] = int.Parse(text[index++]);
            }
        }
    }
}
