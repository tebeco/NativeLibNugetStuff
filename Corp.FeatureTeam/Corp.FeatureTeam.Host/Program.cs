using System;
using Corp.Common.Lib;

namespace Corp.FeatureTeam.Host
{
    class Program
    {
        static void Main(string[] args)
        {
            var utility = new Utility();

            Console.WriteLine("{0}: {1}", 12, utility.DoStuff(12));
            Console.WriteLine("{0}: {1}", 23, utility.DoStuff(23));
        }
    }
}
