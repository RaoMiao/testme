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

        private const int MaxProgressCount = 6; // 进度
        private int[] m_Progress = new int[MaxProgressCount];

        private const int MaxPrevSceneCount = 10; //前置场景数量
        private int[] m_PrevScene = new int[MaxPrevSceneCount];
        private int[] m_PrevSceneProgress = new int[MaxPrevSceneCount];

        /// <summary>
        /// 是否允许多个界面实例。
        /// </summary>
        public bool AllowMultiInstance
        {
            get;
            private set;
        }

        /// <summary>
        /// 是否暂停被其覆盖的界面。
        /// </summary>
        public bool PauseCoveredUIForm
        {
            get;
            private set;
        }

        public int GetProgress(int index)
        {
            return index < m_Progress.Length ? m_Progress[index] : 0;
        }

        public int GetPrevScene(int index)
        {
            return index < m_PrevScene.Length ? m_PrevScene[index] : 0;
        }

        public int GetPrevSceneProgress(int index)
        {
            return index < m_PrevSceneProgress.Length ? m_PrevSceneProgress[index] : 0;
        }

        public void ParseDataRow(string dataRowText)
        {
            string[] text = DataTableExtension.SplitDataRow(dataRowText);
            int index = 0;
            index++;
            Id = int.Parse(text[index++]);
            Name = text[index++];

            for (int i = 0; i < MaxProgressCount; i++)
            {
                m_Progress[i] = int.Parse(text[index++]);
            }

            for (int i = 0; i < MaxPrevSceneCount; i++)
            {
                m_PrevScene[i] = int.Parse(text[index++]);
            }

            for (int i = 0; i < MaxPrevSceneCount; i++)
            {
                m_PrevSceneProgress[i] = int.Parse(text[index++]);
            }
        }
    }
}
