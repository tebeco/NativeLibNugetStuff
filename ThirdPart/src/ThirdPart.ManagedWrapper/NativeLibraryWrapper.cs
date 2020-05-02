using System;
using System.Reflection;
using System.Runtime.InteropServices;

namespace ThirdPart.ManagedWrapper
{

    public static class NativeLibraryWrapper
    {
#if NETCOREAPP3_0 || NETCOREAPP3_1 || NETCOREAPP5_0
        static NativeLibraryWrapper()
        {
            NativeLibrary.SetDllImportResolver(typeof(NativeLibraryWrapper).Assembly, MapAndLoad);

            static IntPtr MapAndLoad(string libraryName, Assembly assembly, DllImportSearchPath? dllImportSearchPath) =>
                NativeLibrary.Load(libraryName, assembly, dllImportSearchPath);
        }

#endif
        [DllImport("third_part_native")]
        public static extern int do_stuff(int num);
    }
}
