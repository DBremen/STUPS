﻿/*
 * Created by SharpDevelop.
 * User: Alexander Petrovskiy
 * Date: 11/5/2013
 * Time: 1:22 AM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace UIAutomation
{
	extern alias UIANET;
	using System;
	using System.Collections;
	using System.ComponentModel;
	using System.Windows.Automation;
	using System.Windows;

	public interface IUiElement : IDisposable //, ISupportsHighlighter
	{
		bool Equals(object obj);
		int GetHashCode();
		int[] GetRuntimeId();
		object GetCurrentPropertyValue(AutomationProperty property);
		object GetCurrentPropertyValue(AutomationProperty property, bool ignoreDefaultValue);
		// object GetCurrentPattern(AutomationPattern pattern);
		// object GetCurrentPattern<N, O>(AutomationPattern pattern) where N : IBasePattern; // where O : AutomationIdentifier;
		// object GetCurrentPattern<N>(AutomationPattern pattern) where N : IBasePattern;
		// IBasePattern GetCurrentPattern<N>(AutomationPattern pattern) where N : IBasePattern;
		TN GetCurrentPattern<TN>(AutomationPattern pattern) where TN : IBasePattern;
		object GetCurrentPattern(AutomationPattern pattern);
		// object GetCurrentPattern<N, O>(object pattern) where N : IBasePattern;
		bool TryGetCurrentPattern(AutomationPattern pattern, out object patternObject);
		object GetCachedPropertyValue(AutomationProperty property);
		object GetCachedPropertyValue(AutomationProperty property, bool ignoreDefaultValue);
		object GetCachedPattern(AutomationPattern pattern);
		bool TryGetCachedPattern(AutomationPattern pattern, out object patternObject);
		AutomationElement GetUpdatedCache(CacheRequest request);
		//AutomationElement FindFirst(TreeScope scope, Condition condition);
		// 20131205
		// UIANET
		// IUiElement FindFirst(TreeScope scope, Condition condition);
		IUiElement FindFirst(TreeScope scope, System.Windows.Automation.Condition condition);
		//AutomationElementCollection FindAll(TreeScope scope, Condition condition);
		// 20131205
		// UIANET
		// IUiEltCollection FindAll(TreeScope scope, Condition condition);
		IUiEltCollection FindAll(TreeScope scope, System.Windows.Automation.Condition condition);
		AutomationProperty[] GetSupportedProperties();
		// 20131209
		// AutomationPattern[] GetSupportedPatterns();
		IBasePattern[] GetSupportedPatterns();
		void SetFocus();
		//bool TryGetClickablePoint(out Point pt);
		bool TryGetClickablePoint(out Point pt);
		//Point GetClickablePoint();
		Point GetClickablePoint();
		// 20131114
		//AutomationElement.AutomationElementInformation Cached { get; }
		IUiElementInformation Cached { get; }
		// 20131114
		//AutomationElement.AutomationElementInformation Current { get; }
		IUiElementInformation Current { get; }
		// 20131114
		//AutomationElement CachedParent { get; }
		IUiElement CachedParent { get; }
		// 20131114
		//AutomationElementCollection CachedChildren { get; }
		IUiEltCollection CachedChildren { get; }

		//AutomationElement SourceElement { get; }
		//AutomationElement SourceElement { get; set; }
		//T GetSourceElement<T>();
		//void SetSourceElement<T>(T element);
		AutomationElement GetSourceElement();
		// void SetSourceElement(AutomationElement element);
		void SetSourceElement<T>(T element);
		//IUiElement GetSourceElement();
		//void SetSourceElement(IUiElement element);

		string Tag { get; set; }
		//void Dispose();

		// internal methods
		object GetPatternPropertyValue(AutomationProperty property, bool useCache);

		// InnerElementTypes InnerElementType { get; set; }

		// NavigateTo
		IUiElement NavigateToParent();
		IUiElement NavigateToFirstChild();
		IUiElement NavigateToLastChild();
		IUiElement NavigateToNextSibling();
		IUiElement NavigateToPreviousSibling();

		// Patterns
//        IUiElement Click();
//        IUiElement DoubleClick();
//        string Value { get; set; }

		// HIghlighter
		IUiElement Highlight();
	}
}
