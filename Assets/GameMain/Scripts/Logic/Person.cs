﻿using System.Collections.Generic;

namespace MiniJY
{
    //JYGame Person实例
    public class Person
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
        /// 头像编号。
        /// </summary>
        public int PicId
        {
            get;
            protected set;
        }

        /// <summary>
        /// 战斗代号。
        /// </summary>
        public int BattleId
        {
            get;
            protected set;
        }

        /// <summary>
        /// 姓名。
        /// </summary>
        public string Name
        {
            get;
            protected set;
        }

        /// <summary>
        /// 外号。
        /// </summary>
        public string Waihao
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
        /// 等级。
        /// </summary>
        public int Level
        {
            get;
            protected set;
        }

        /// <summary>
        /// 实战。
        /// </summary>
        public int Shizhan
        {
            get;
            protected set;
        }

        /// <summary>
        /// 潜能。
        /// </summary>
        public int QianNeng
        {
            get;
            protected set;
        }

        /// <summary>
        /// 生命。
        /// </summary>
        public int Hp
        {
            get;
            protected set;
        }

        /// <summary>
        /// 生命最大值。
        /// </summary>
        public int HpMax
        {
            get;
            protected set;
        }

        /// <summary>
        /// 内力性质。
        /// </summary>
        public int MpType
        {
            get;
            protected set;
        }

        /// <summary>
        /// 内力。
        /// </summary>
        public int Mp
        {
            get;
            protected set;
        }

        /// <summary>
        /// 内力。
        /// </summary>
        public int MpMax
        {
            get;
            protected set;
        }

        /// <summary>
        /// 体力。
        /// </summary>
        public int Tili
        {
            get;
            protected set;
        }


        /// <summary>
        /// 名声。
        /// </summary>
        public int Mingsheng
        {
            get;
            protected set;
        }

        /// <summary>
        /// 臂力。
        /// </summary>
        public int Bili
        {
            get;
            protected set;
        }

        /// <summary>
        /// 悟性。
        /// </summary>
        public int Wuxing
        {
            get;
            protected set;
        }

        /// <summary>
        /// 根骨。
        /// </summary>
        public int Genggu
        {
            get;
            protected set;
        }

        /// <summary>
        /// 机敏。
        /// </summary>
        public int Jimin
        {
            get;
            protected set;
        }

        /// <summary>
        /// 福缘。
        /// </summary>
        public int FuYuan
        {
            get;
            protected set;
        }

        /// <summary>
        /// 门派。
        /// </summary>
        public int MenPai
        {
            get;
            protected set;
        }

        /// <summary>
        /// 位置。
        /// </summary>
        public int Pos
        {
            get;
            protected set;
        }

        private const int KongfuCount = 5; // 进度
        private int[] m_Kongfu = new int[KongfuCount];
        private int[] m_KongfuLevel = new int[KongfuCount];

        public int GetKongfu(int index)
        {
            return index < m_Kongfu.Length ? m_Kongfu[index] : 0;
        }

        public int GetKongfuLevel(int index)
        {
            return index < m_KongfuLevel.Length ? m_KongfuLevel[index] : 0;
        }

        /// <summary>
        /// 内功。
        /// </summary>
        public int Neigong
        {
            get;
            protected set;
        }

        /// <summary>
        /// 内功等级。
        /// </summary>
        public int NeigongLevel
        {
            get;
            protected set;
        }

        /// <summary>
        /// 轻功。
        /// </summary>
        public int Qingong
        {
            get;
            protected set;
        }

        /// <summary>
        /// 轻功等级。
        /// </summary>
        public int QingongLevel
        {
            get;
            protected set;
        }

        /// <summary>
        /// 特技。
        /// </summary>
        public int Teji
        {
            get;
            protected set;
        }

        /// <summary>
        /// 特技等级。
        /// </summary>
        public int TejiLevel
        {
            get;
            protected set;
        }

        /// <summary>
        /// 招架。
        /// </summary>
        public int Zhaojia
        {
            get;
            protected set;
        }

        /// <summary>
        /// 招架等级。
        /// </summary>
        public int ZhaojiaLevel
        {
            get;
            protected set;
        }

        /// <summary>
        /// 武器。
        /// </summary>
        public int Weapon
        {
            get;
            protected set;
        }

        private const int MAXDROP = 5; // 进度
        private int[] m_Drops = new int[MAXDROP];

        public int GetDrop(int index)
        {
            return index < m_Drops.Length ? m_Drops[index] : 0;
        }

        /// <summary>
        /// 掉落武器。
        /// </summary>
        public int DropWeapon
        {
            get;
            protected set;
        }

        /// <summary>
        /// 图鉴。
        /// </summary>
        public int TuJian
        {
            get;
            protected set;
        }

    }
}