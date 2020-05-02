using ThirdPart.ManagedWrapper;

namespace Corp.Common.Lib
{
    public class Utility
    {
        public int DoStuff(int num)
        {
            return NativeLibraryWrapper.do_stuff(num);
        }
    }
}
