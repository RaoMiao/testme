using GameFramework.DataTable;
using System.Collections.Generic;

namespace MiniJY
{
    /// <summary>
    /// 物品表。
    /// </summary>
    public class DRItem : IDataRow
    {
        private const int MaxKongfuCount = 3; // 最大武器数量
        private int[] m_NeedKongfu = new int[MaxKongfuCount];

        /// <summary>
        /// 编号。
        /// </summary>
        public int Id
        {
            get;
            protected set;
        }

        /// <summary>
        /// 物品名。
        /// </summary>
        public string Name
        {
            get;
            private set;
        }

        /// <summary>
        /// 物品说明。
        /// </summary>
        public string Desc
        {
            get;
            private set;
        }

        /// <summary>
        /// NotUse 不是很懂
        /// </summary>
        public int Check
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
        /// 生命。
        /// </summary>
        public int Hp
        {
            get;
            private set;
        }

        /// <summary>
        /// 内力。
        /// </summary>
        public int Mp
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
        /// 命中。
        /// </summary>
        public int Hit
        {
            get;
            private set;
        }

        /// <summary>
        /// 格挡。
        /// </summary>
        public int Block
        {
            get;
            private set;
        }

        /// <summary>
        /// 闪避。
        /// </summary>
        public int Dodge
        {
            get;
            private set;
        }

        public int GetKongfu(int index)
        {
            return index < m_NeedKongfu.Length ? m_NeedKongfu[index] : 0;
        }

        /// <summary>
        /// 需武功等级。
        /// </summary>
        public int NeedKongfuLevel
        {
            get;
            private set;
        }

        /// <summary>
        /// 需人物等级。
        /// </summary>
        public int NeedPersonLevel
        {
            get;
            private set;
        }

        /// <summary>
        /// 需通关场景。
        /// </summary>
        public int NeedPassScene
        {
            get;
            private set;
        }

        /// <summary>
        /// 需通关场景进度。
        /// </summary>
        public int NeedPassSceneRate
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
            Desc = text[index++];
            Check = int.Parse(text[index++]);
            Type = text[index++];
            Hp = int.Parse(text[index++]);
            Mp = int.Parse(text[index++]);
            Damage = int.Parse(text[index++]);
            Hit = int.Parse(text[index++]);
            Block = int.Parse(text[index++]);
            Dodge = int.Parse(text[index++]);
            for (int i = 0; i < MaxKongfuCount; ++i)
            {
                m_NeedKongfu[i] = int.Parse(text[index++]);
            }
            NeedKongfuLevel = int.Parse(text[index++]);
            NeedPersonLevel = int.Parse(text[index++]);
            NeedPassScene = int.Parse(text[index++]);
            NeedPassSceneRate = int.Parse(text[index++]);
        }
    }
}
