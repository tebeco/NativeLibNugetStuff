using System;
using ThirdPart.ManagedWrapper;

namespace ThirdPartSample
{
    class Program
    {
        static void Main(string[] args)
        {
            var result = NativeLibraryWrapper.do_stuff(4);
            Console.WriteLine($"The third part lib returned : {result}");
        }
    }
}
