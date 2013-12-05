﻿/*
 * Created by SharpDevelop.
 * User: Alexander Petrovskiy
 * Date: 17/02/2012
 * Time: 12:23 a.m.
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace UIAutomation.Commands
{
    extern alias UIANET;
    using System;
    using System.Management.Automation;
    using System.Windows.Automation;

    /// <summary>
    /// Description of TestUiaControlStateCommand.
    /// </summary>
    // 20130130
    //[Cmdlet(VerbsDiagnostic.Test, "UiaControlState")]
    [Cmdlet(VerbsDiagnostic.Test, "UiaControlState", DefaultParameterSetName = "Search")]
    [OutputType(new[] { typeof(object) })]
    public class TestUiaControlStateCommand : GetControlStateCmdletBase
    {
        #region Parameters
        [Parameter]
        internal new int Timeout { get; set; }
        #endregion Parameters
        
        /// <summary>
        /// Processes the pipeline.
        /// </summary>
        protected override void ProcessRecord()
        {
            if (!CheckAndPrepareInput(this)) { return; }
            
            bool result = 
                TestControlByPropertiesFromHashtable(
                    InputObject,
                    SearchCriteria,
                    Preferences.Timeout);
            WriteObject(this, result);

            /*
            if (result) {
                this.WriteObject(this, true);
            } else {
                this.WriteObject(this, false);
            }
            */
        }
    }
}
