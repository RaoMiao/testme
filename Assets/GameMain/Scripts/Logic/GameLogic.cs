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

        //节
        public int m_Base_Jie = 0;

        //黄金
        public int m_Base_Gold = 0;

        //臂力
        public int m_Base_Bili = 4;

        //根骨       
        public int m_Base_Gengu = 4;

        //机敏       
        public int m_Base_JiMin = 4;

        //悟性      
        public int m_Base_Wuxing = 4;

        //福缘
        public int m_Base_FuYuan = 4;

        //生命
        public int m_Base_Hp = 4;

        //生命
        public int m_Base_Mp = 4;

        //属性加值
        //臂力
        public int m_Base_BiliAddon = 0;

        //根骨       
        public int m_Base_GenguAddon = 0;

        //机敏       
        public int m_Base_JiMinAddon = 0;

        //悟性      
        public int m_Base_WuxingAddon = 0;

        //福缘
        public int m_Base_FuYuanAddon = 0;

        //生命
        public int m_Base_HpAddon = 0;

        //生命
        public int m_Base_MpAddon = 0;

        //修炼备选
        public int m_Base_MusicOn = 1;
        //自宫
        public int m_Base_Zigong = 0;

        //伤害
        public int m_Base_BasicDamage = 0;

        //命中
        public int m_Base_BasicHit = 0;

        //格挡
        public int m_Base_BasicBlock = 0;

        //闪避
        public int m_Base_BasicDodge = 0;

        //Person 
        public Dictionary<int, Person> m_Persons = new Dictionary<int, Person>();

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
            m_pid = 0;
            for(int i = 0; i < AT_MAX; i++)
            {
                m_Base_Addon[i] = 0;
            }

            m_Base_Qianneng = 500;
            m_Base_ShiZhan = 0;
            m_Base_Jie = 0;


            m_Persons[m_pid].HpMax = 100;
            m_Persons[m_pid].MpMax = 80;

            m_Persons[m_pid].Hp = m_Persons[m_pid].HpMax;
            m_Persons[m_pid].Mp = m_Persons[m_pid].MpMax;
    
    // for i,v in pairs({"膂力","根骨","机敏","悟性","福缘"}) do
    //     JY.Person[JY.pid][v]=4; 
    //     JY.Base[v.."成长"]=0; 
    // end
    // JY.Base["自由属性点"]=10;
    // JY.Base["相性"]=math.random(256)-1; 
    // SetFreePoint();
    // for i=1,5 do
    //     if JY.Person[JY.pid]["武功"..i]>0 then
    //         local n=JY.Person[JY.pid]["武功"..i]
    //         JY.Base["武功等级"..n]=JY.Person[JY.pid]["武功等级"..i];
    //     end
    // end
    // for i,v in pairs({"内功","轻功","特技"}) do
    //     if JY.Person[JY.pid][v]>0 then
    //     local n=JY.Person[JY.pid][v]
    //         JY.Base["武功等级"..n]=JY.Person[JY.pid][v.."等级"];
    //     end
    // end 
        }

        //读取存档记录
        public void LoadRecord(int id)
        {

        }
    }
}
