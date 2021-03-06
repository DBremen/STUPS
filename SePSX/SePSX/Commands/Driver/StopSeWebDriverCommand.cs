﻿/*
 * Created by SharpDevelop.
 * User: Alexander Petrovskiy
 * Date: 7/18/2012
 * Time: 9:27 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace SePSX.Commands
{
    using System;
    using System.Management.Automation;
    using OpenQA.Selenium;

    /// <summary>
    /// Description of StopSeWebDriverCommand.
    /// </summary>
    [Cmdlet(VerbsLifecycle.Stop, "SeWebDriver", DefaultParameterSetName = "ByName")]
    [OutputType(typeof(bool))]
    public class StopSeWebDriverCommand : DriverCmdletBase
    {
        public StopSeWebDriverCommand()
        {
        }
        
        #region Parameters
        [Parameter(Mandatory = false,
                   ParameterSetName = "ByName")]
        internal string DriverName { get; set; }
        
//        [Parameter(Mandatory = false,
//                   ParameterSetName = "ByName")]
//        public string[] InstanceName { get; set; }
        
        [Parameter(Mandatory = false,
                   ValueFromPipeline = true,
                   ParameterSetName = "ByInput")]
        public IWebDriver[] InputObject { get; set; }
        #endregion Parameters
        
        protected override void BeginProcessing()
        {
            CheckCmdletParameters();
            
            if (InstanceName != null &&
                //this.InstanceName != string.Empty &&
                InstanceName.Length > 0) {
                
                try {
                    for (var i = 0; i < InstanceName.Length; i++) {
                        if (InstanceName[i] != string.Empty) {
                            var driver = 
                                CurrentData.Drivers[InstanceName[i]];
                            
                            if (driver.Equals(CurrentData.CurrentWebDriver)) {
                                CurrentData.CurrentWebDriver = null;
                            }
                            
                            CurrentData.Drivers.Remove(InstanceName[i]);
                            
                            driver.Quit();
                            //CurrentData.CurrentWebDriver = null;
                            WriteObject(this, true);
                        }
                    }
                }
                catch (Exception eFailed) {
                    CurrentData.CurrentWebDriver = null;
                    WriteError(
                        this,
                        "Failed to stop the driver. " +
                        eFailed.Message,
                        "FailedStopDriver",
                        ErrorCategory.InvalidOperation,
                        true);
                }
            }
        }
        
        protected override void ProcessRecord()
        {
            if (InputObject != null &&
                InputObject is IWebDriver[]) {
                
                foreach (var driver in InputObject) {
                    
                    try {
                        foreach (var driverPair in CurrentData.Drivers) {
                            if (driverPair.Value == driver) {
                                CurrentData.Drivers.Remove(driverPair.Key);
                                break;
                            }
                        }
                        
                        driver.Quit();
                        
                        WriteObject(this, true);
                    }
                    catch (Exception eFailed) {
                        WriteError(
                            this,
                            "Failed to stop the driver. " +
                            eFailed.Message,
                            "FailedStopDriver",
                            ErrorCategory.InvalidOperation,
                            true);
                    }
                }
            }
        }
    }
    
    /// <summary>
    /// 
    /// </summary>
    [Cmdlet(VerbsLifecycle.Stop, "SeFirefox", DefaultParameterSetName = "ByName")]
    public class StopSeFirefoxCommand : StopSeWebDriverCommand
    {
        public StopSeFirefoxCommand(){}
    }
    
    /// <summary>
    /// 
    /// </summary>
    [Cmdlet(VerbsLifecycle.Stop, "SeChrome", DefaultParameterSetName = "ByName")]
    public class StopSeChromeCommand : StopSeWebDriverCommand
    {
        public StopSeChromeCommand(){}
    }
    
    /// <summary>
    /// 
    /// </summary>
    [Cmdlet(VerbsLifecycle.Stop, "SeInternetExplorer", DefaultParameterSetName = "ByName")]
    public class StopSeInternetExplorerCommand : StopSeWebDriverCommand
    {
        public StopSeInternetExplorerCommand(){}
    }
    
//    /// <summary>
//    /// 
//    /// </summary>
//    [Cmdlet(VerbsLifecycle.Stop, "SeSafari", DefaultParameterSetName = "ByName")]
//    internal class StopSeSafariCommand : StopSeWebDriverCommand
//    {
//        public StopSeSafariCommand(){}
//    }
//    
//    /// <summary>
//    /// 
//    /// </summary>
//    [Cmdlet(VerbsLifecycle.Stop, "SeOpera", DefaultParameterSetName = "ByName")]
//    internal class StopSeOperaCommand : StopSeWebDriverCommand
//    {
//        public StopSeOperaCommand(){}
//    }
//    
//    /// <summary>
//    /// 
//    /// </summary>
//    [Cmdlet(VerbsLifecycle.Stop, "SeAndroid", DefaultParameterSetName = "ByName")]
//    internal class StopSeAndroidCommand : StopSeWebDriverCommand
//    {
//        public StopSeAndroidCommand(){}
//    }
//    
//    /// <summary>
//    /// 
//    /// </summary>
//    [Cmdlet(VerbsLifecycle.Stop, "SeHTMLUnit", DefaultParameterSetName = "ByName")]
//    public class StopSeHTMLUnitCommand : StopSeWebDriverCommand
//    {
//        public StopSeHTMLUnitCommand(){}
//    }
}
