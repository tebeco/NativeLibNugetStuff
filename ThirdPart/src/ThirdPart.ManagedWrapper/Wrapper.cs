using System.Runtime.InteropServices;

namespace ThirdPart.ManagedWrapper
{
    public static class NativeLibrary
    {
        [DllImport("third_part_native.dll")]
        public static extern int do_stuff(int num);
    }
}
