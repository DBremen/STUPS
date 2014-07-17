﻿/*
 * Created by SharpDevelop.
 * User: Alexander Petrovskiy
 * Date: 12/20/2012
 * Time: 1:39 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace TMX
{
    using System;
    using System.Management.Automation;
    
    /// <summary>
    /// Description of TmxAddTestCaseCommand.
    /// </summary>
    class TmxAddTestCaseCommand : TmxCommand
    {
        internal TmxAddTestCaseCommand(CommonCmdletBase cmdlet) : base (cmdlet)
        {
        }
        
        internal override void Execute()
        {
            var cmdlet = (AddTestCaseCmdletBase)Cmdlet;
            
            bool result = TmxHelper.AddTestCase(cmdlet);
            
            if (result)
                cmdlet.WriteObject(
                    cmdlet,
                    TestData.CurrentTestCase);
            else
                cmdlet.WriteError(
                    cmdlet,
                    "Couldn't add a test case",
                    "AddingTestCase",
                    ErrorCategory.InvalidArgument,
                    true);
        }
    }
}
