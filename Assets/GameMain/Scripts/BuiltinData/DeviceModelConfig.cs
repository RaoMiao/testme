using System.Collections.Generic;
using UnityEngine;

namespace MiniJY
{
    public class DeviceModelConfig : ScriptableObject
    {
        [SerializeField]
        private List<DeviceModel> m_DeviceModels = null;

        public DeviceModel[] GetDeviceModels()
        {
            return m_DeviceModels.ToArray();
        }

        public void NewDeviceModel()
        {
            m_DeviceModels.Add(new DeviceModel());
        }

        public void RemoveDeviceModelAt(int index)
        {
            m_DeviceModels.RemoveAt(index);
        }
    }
}
