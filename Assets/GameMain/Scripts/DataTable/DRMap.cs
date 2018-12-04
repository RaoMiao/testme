using GameFramework.DataTable;
using System.Collections.Generic;

namespace MiniJY
{
    /// <summary>
    /// 地图表。
    /// </summary>
    public class DRMap : IDataRow
    {
        /// <summary>
        /// ID。
        /// </summary>
        public int Id
        {
            get;
            protected set;
        }

        /// <summary>
        /// 场景。
        /// </summary>
        public string Name
        {
            get;
            private set;
        }

        /// <summary>
        /// 图片。
        /// </summary>
        public int Pic
        {
            get;
            private set;
        }

        /// <summary>
        /// 音乐。
        /// </summary>
        public int Music
        {
            get;
            private set;
        }

        private const int ZaBingCount = 20; // 
        private int[] m_ZaBing = new int[ZaBingCount];

        private const int SmallBossCount = 10; // 
        private int[] m_SmallBoss = new int[SmallBossCount];

        /// <summary>
        /// 大Boss。
        /// </summary>
        public int BigBoss
        {
            get;
            private set;
        }

        private const int PassBossCount = 10; // 
        private int[] m_PassBoss = new int[PassBossCount];

        public int GetZaBing(int index)
        {
            return index < m_ZaBing.Length ? m_ZaBing[index] : 0;
        }

        public int GetSmallBoss(int index)
        {
            return index < m_SmallBoss.Length ? m_SmallBoss[index] : 0;
        }

        public int GetPassBoss(int index)
        {
            return index < m_PassBoss.Length ? m_PassBoss[index] : 0;
        }

        private const int BeforeFightCount = 10; // 
        private int[] m_BeforeFight = new int[BeforeFightCount];

        private const int AfterFightCount = 10; // 
        private int[] m_AfterFight = new int[AfterFightCount];

        public int GetBeforeFight(int index)
        {
            return index < m_BeforeFight.Length ? m_BeforeFight[index] : 0;
        }

        public int GetAfterFight(int index)
        {
            return index < m_AfterFight.Length ? m_AfterFight[index] : 0;
        }

        public void ParseDataRow(string dataRowText)
        {
            string[] text = DataTableExtension.SplitDataRow(dataRowText);
            int index = 0;
            index++;
            Id = int.Parse(text[index++]);
            Name = text[index++];
            Pic = int.Parse(text[index++]);
            Music = int.Parse(text[index++]);

            for (int i = 0; i < ZaBingCount; i++)
            {
                m_ZaBing[i] = int.Parse(text[index++]);
            }

            for (int i = 0; i < SmallBossCount; i++)
            {
                m_SmallBoss[i] = int.Parse(text[index++]);
            }

            BigBoss = int.Parse(text[index++]);

            for (int i = 0; i < PassBossCount; i++)
            {
                m_PassBoss[i] = int.Parse(text[index++]);
            }

            for (int i = 0; i < BeforeFightCount; i++)
            {
                m_BeforeFight[i] = int.Parse(text[index++]);
            }

            for (int i = 0; i < AfterFightCount; i++)
            {
                m_AfterFight[i] = int.Parse(text[index++]);
            }
        }
    }
}
