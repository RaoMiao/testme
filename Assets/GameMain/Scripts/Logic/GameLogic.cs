using System.Collections.Generic;

namespace MiniJY
{
    //JYGame
    public class GameLogic
    {
        public enum GameState
        {
            GAME_START = 0, //--开始画面, 各种选单
            GAME_AUTO = 1, //
            GAME_FIGHT = 2,
            GAME_LEARN = 3,
            GAME_WMAP = 4,
            GAME_WMAP2 = 5,
            GAME_DEAD = 6,
            GAME_END = 7,
            GAME_WARWIN = 8,
            GAME_WARLOSE = 9,
        }

        public const int TeamNum = 16;   //队伍人数
        public const int MyThingNum = 400; //主角物品数量
        public const int Kungfunum = 5;    // 角色武功数量
        public const int MaxKungfuNum = 80;

        private static GameLogic _instance;

        //SPD？？
        public int m_spd = 1;
        //游戏状态
        public GameState m_gameState = GameState.GAME_START;
        //延时
        public int m_wait = 0;
        //显示文本
        public List<string> m_text = new List<string>();
        //待显示文本
        public string m_textBuff;
        //？？
        public int m_helpIndex = 0;
        //??
        public string m_centerMsg = "";
        //??
        public int m_eft1 = 0;
        //??
        public int m_eft2 = 0;
        //??
        public int m_pid = 0;
        //??
        public int m_eid = 0;
        //战斗信息
        public List<string> m_info = new List<string>();
        //??
        public int m_current = 0;
        //??
        public bool m_hold = false;
        //??
        public int m_kfCurrentPage = 0;
        //??
        public int m_kfMaxPage = 0;
        //??
        public int m_learnKfid = 0;
        //??
        public int m_logCurrentPage = 0;
        //??
        public int m_logMaxPage = 0;
        //??
        public int m_personStatusPage = 0;

        //Base 数据
        public int m_Base_BossTimer = 900;
    
        //MAX SPD
        public int m_Base_MaxSPD = 999;

        //下个场景
        public int m_Base_NextScene = 1;

        //当前地图
        public int m_Base_CurrentMap = 1;

        //当前场景
        public int m_Base_CurrentScene = 0;

        //当前音乐
        public int m_Base_CurrentMusic = -1;

        //当前事件
        public int m_Base_CurrentEvent = 0;

        //倒计时
        public int m_Base_CountDown = 900;

        //力量
        public int m_Base_Strength = 0;

        //自由属性点
        public int m_Base_FreePoint = 0;

        //体力
        public int m_Base_Tili = 100;

        //实战
        public int m_Base_ShiZhan = 0;

        //潜能
        public int m_Base_Qianneng = 500;

        //黄金
        public int m_Base_Gold = 0;

        enum AttrType
        {
            //臂力
            AT_BILI,
            //根骨
            AT_GENGU,
            //机敏
            AT_JIMIN,
            //悟性
            AT_WUXING,
            //福缘
            AT_FUYUAN,
            //生命            AT_HP,            //内力            AT_MP,
            //所有值
            AT_MAX,
        }
        //属性成长
        public int[] m_Base_ChengZhang = new int[(int)AttrType.AT_MAX] {4,4,4,4,4,4,4};
        //属性加值
        public int[] m_Base_Addon = new int[(int)AttrType.AT_MAX] {0,0,0,0,0,0,0};
        //修炼备选
        public int m_Base_MusicOn = 1;
        //自宫
        public int m_Base_Zigong = 0;

        enum AttrType2
        {
            ATT2_DAMAGE,
            ATT2_HIT,
            ATT2_BLOCK,
            ATT2_DODGE,
            ATT2_MAX,
        }

        public int[] m_Base_BasicAttr2 = new int[(int)AttrType2.ATT2_MAX] {0, 0, 0, 0 };

        public static GameLogic Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new GameLogic();
                }
                    
                return _instance;
            }
        }

        //创建新角色
        public void NewPerson()
        {

        }

        //重置玩家属性
        public void ResetAttrib()
        {

        }

        //读取存档记录
        public void LoadRecord(int id)
        {

        }
    }
}
