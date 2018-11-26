using System;
using UnityEngine;

namespace MiniJY
{
    [Serializable]
    public class DeviceModel
    {
        [SerializeField]
        private string m_DeviceName = null;

        [SerializeField]
        private string m_ModelName = null;

        public string DeviceName
        {
            get
            {
                return m_DeviceName;
            }
        }

        public string ModelName
        {
            get
            {
                return m_ModelName;
            }
        }
    }
}
