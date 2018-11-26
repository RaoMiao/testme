using GameFramework;
using GameFramework.DataTable;
using GameFramework.Sound;
using UnityGameFramework.Runtime;

namespace MiniJY
{
    public static class SoundExtension
    {
        private const float FadeVolumeDuration = 1f;
        private static int? s_MusicSerialId = null;


        public static void StopMusic(this SoundComponent soundComponent)
        {
            if (!s_MusicSerialId.HasValue)
            {
                return;
            }

            soundComponent.StopSound(s_MusicSerialId.Value, FadeVolumeDuration);
            s_MusicSerialId = null;
        }

        public static int? PlayUISound(this SoundComponent soundComponent, int uiSoundId, object userData = null)
        {
            IDataTable<DRUISound> dtUISound = GameEntry.DataTable.GetDataTable<DRUISound>();
            DRUISound drUISound = dtUISound.GetDataRow(uiSoundId);
            if (drUISound == null)
            {
                Log.Warning("Can not load UI sound '{0}' from data table.", uiSoundId.ToString());
                return null;
            }

            PlaySoundParams playSoundParams = new PlaySoundParams
            {
                Priority = drUISound.Priority,
                Loop = false,
                VolumeInSoundGroup = drUISound.Volume,
                SpatialBlend = 0f,
            };

            return soundComponent.PlaySound(AssetUtility.GetUISoundAsset(drUISound.AssetName), "UISound", Constant.AssetPriority.UISoundAsset, playSoundParams, userData);
        }

        public static bool IsMuted(this SoundComponent soundComponent, string soundGroupName)
        {
            if (string.IsNullOrEmpty(soundGroupName))
            {
                Log.Warning("Sound group is invalid.");
                return true;
            }

            ISoundGroup soundGroup = soundComponent.GetSoundGroup(soundGroupName);
            if (soundGroup == null)
            {
                Log.Warning("Sound group '{0}' is invalid.", soundGroupName);
                return true;
            }

            return soundGroup.Mute;
        }

        public static void Mute(this SoundComponent soundComponent, string soundGroupName, bool mute)
        {
            if (string.IsNullOrEmpty(soundGroupName))
            {
                Log.Warning("Sound group is invalid.");
                return;
            }

            ISoundGroup soundGroup = soundComponent.GetSoundGroup(soundGroupName);
            if (soundGroup == null)
            {
                Log.Warning("Sound group '{0}' is invalid.", soundGroupName);
                return;
            }

            soundGroup.Mute = mute;

            GameEntry.Setting.SetBool(string.Format(Constant.Setting.SoundGroupMuted, soundGroupName), mute);
            GameEntry.Setting.Save();
        }

        public static float GetVolume(this SoundComponent soundComponent, string soundGroupName)
        {
            if (string.IsNullOrEmpty(soundGroupName))
            {
                Log.Warning("Sound group is invalid.");
                return 0f;
            }

            ISoundGroup soundGroup = soundComponent.GetSoundGroup(soundGroupName);
            if (soundGroup == null)
            {
                Log.Warning("Sound group '{0}' is invalid.", soundGroupName);
                return 0f;
            }

            return soundGroup.Volume;
        }

        public static void SetVolume(this SoundComponent soundComponent, string soundGroupName, float volume)
        {
            if (string.IsNullOrEmpty(soundGroupName))
            {
                Log.Warning("Sound group is invalid.");
                return;
            }

            ISoundGroup soundGroup = soundComponent.GetSoundGroup(soundGroupName);
            if (soundGroup == null)
            {
                Log.Warning("Sound group '{0}' is invalid.", soundGroupName);
                return;
            }

            soundGroup.Volume = volume;

            GameEntry.Setting.SetFloat(string.Format(Constant.Setting.SoundGroupVolume, soundGroupName), volume);
            GameEntry.Setting.Save();
        }
    }
}
