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
        //??存键值的表 
        public Dictionary<string, int> m_base = new Dictionary<string, int>();
        //人物个数
        public int m_personNum = 0;
        //人物数据
        public List<Dictionary<string, int>> m_person = new List<Dictionary<string, int>>();
        //人物个数
        public int m_forceNum = 0;
        //人物数据
        public List<Dictionary<string, int>> m_force = new List<Dictionary<string, int>>();
        //场景个数
        public int m_mapNum=0;
        //场景数据
        public Dictionary<int, Dictionary<string,int>> m_map = new Dictionary<int, Dictionary<string, int>>();


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

    }
}
