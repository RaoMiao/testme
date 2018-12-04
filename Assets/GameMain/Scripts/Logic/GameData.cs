using System.Collections.Generic;

namespace MiniJY
{
    //JYGame
    public class GameData
    {
        private static GameData _instance;

        public static GameData Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new GameData();
                }
                    
                return _instance;
            }
        }
        

    }
}
