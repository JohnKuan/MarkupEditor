//
//  MarkupEditor.swift
//  MarkupEditor
//
//  Created by Steven Harris on 8/8/22.
//

import UIKit
import UniformTypeIdentifiers

/// The MarkupEditor struct holds onto all the state needed across the toolbars, views, and other
/// machinery encompassed in it.
///
/// The state is all held in statics to provide convenient access. The MarkupEditor holds onto several
/// ObservableObjects used by the toolbars.
public struct MarkupEditor {
    
    public static let markupMenu = MarkupMenu()
    public static let toolbarContents = ToolbarContents.shared
    public static let toolbarStyle = ToolbarStyle()
    public static let observedWebView: ObservedWebView = ObservedWebView()
    public static var selectedWebView: MarkupWKWebView? {
        get { observedWebView.selectedWebView }
        set { observedWebView.selectedWebView = newValue }
    }
    public static let selectionState: SelectionState = SelectionState()
    public static let selectImage: SelectImage = SelectImage()
    public static let supportedImageTypes: [UTType] = [.image, .movie]
    public static let showSubToolbar = ShowSubToolbar()
    public static var style: ToolbarStyle.Style = .labeled {
        didSet {
            toolbarStyle.style = style
        }
    }
    public static var allowLocalImages: Bool = false
    
    public static func initMenu(with builder: UIMenuBuilder) {
        markupMenu.initMenu(with: builder)
    }

}

/// The observable object containing the selectedWebView.
///
/// In cases where a single MarkupToolbar is being used with multiple MarkupWKWebViews, we need
/// to be able to track which is selected so that the MarkupToolbar reflects its state properly.
public class ObservedWebView: ObservableObject, Identifiable {
    @Published public var selectedWebView: MarkupWKWebView?
    public var id: UUID = UUID()
    
    public init(_ webView: MarkupWKWebView? = nil) {
        selectedWebView = webView
    }
}

/// The observable object containing the Bool that tells us whether the DocumentPicker should be
/// shown to select a local image.
public class SelectImage: ObservableObject {
    @Published public var value: Bool
    
    public init(_ value: Bool = false) {
        self.value = value
    }
}

/// The observable object containing the type of SubToolbar to show, or nil for none.
public class ShowSubToolbar: ObservableObject {
    @Published public var type: SubToolbar.ToolbarType?
    
    public init(_ type: SubToolbar.ToolbarType? = nil) {}
}
