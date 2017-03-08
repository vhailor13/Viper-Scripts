#!/bin/bash

# Protocols
PROTOCOLS_FILENAME="Protocols/$1Protocols.swift"
PROTOCOLS_CONTENT="
import UIKit\n
\n
// MARK: - View\n
protocol $1ViewProtocol: class {\n
\tvar presenter: $1PresenterProtocol? { get set }\n
}\n
\n
// MARK: - Wireframe\n
protocol $1WireframeProtocol: class {\n
\n
}\n
\n
// MARK: - Presenter\n
protocol $1PresenterProtocol: class {\n
\tweak var view: $1ViewProtocol? { get set }\n
\tvar wireframe: $1WireframeProtocol? { get set }\n
\tvar interactor: $1InteractorProtocol? { get set }\n
\n
\tfunc viewDidLoad()\n
}\n
\n
// MARK: - Interactor\n
protocol $1InteractorProtocol: class {\n
\n
}
"
mkdir Protocols
echo $PROTOCOLS_CONTENT>$PROTOCOLS_FILENAME

#View
VIEW_FILENAME="$1View.swift"
VIEW_CONTENT="
import UIKit\n
\n
class $1View: UIViewController, $1ViewProtocol {\n
\tvar presenter: $1PresenterProtocol?\n
}
"
echo $VIEW_CONTENT>$VIEW_FILENAME

#Wireframe
WIREFRAME_FILENAME="$1Wireframe.swift"
WIREFRAME_CONTENT="
import UIKit\n
\n
class $1Wireframe: $1WireframeProtocol {\n
\n
}
"
echo $WIREFRAME_CONTENT>$WIREFRAME_FILENAME

#Interactor
INTERACTOR_FILENAME="$1Interactor.swift"
INTERACTOR_CONTENT="
class $1Interactor: $1InteractorProtocol {\n
\n    
}
"
echo $INTERACTOR_CONTENT>$INTERACTOR_FILENAME

#Assembly
ASSEMBLY_FILENAME="$1Assembly.swift"
ASSEMBLY_CONTENT="
import UIKit\n
\n
class $1Assembly {\n
\t\t    static func create$1Module() -> UIViewController {\n
\t\t\t        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "\"$1View\"")\n
\t\t\t        if let view = viewController as? $1View {\n
\t\t\t            let presenter: $1PresenterProtocol = $1Presenter()\n
\t\t\t            let wireframe: $1WireframeProtocol = $1Wireframe()\n
\t\t\t            let interactor: $1InteractorProtocol = $1Interactor()\n
\n            
\t\t\t            view.presenter = presenter\n
\n
\t\t\t            presenter.view = view\n
\t\t\t            presenter.wireframe = wireframe\n
\t\t\t            presenter.interactor = interactor\n
\n            
\t\t\t            return viewController\n
\t\t        }\n
\n        
\t\t        return UIViewController()\n
\t    }\n
\n    
\t    static var mainStoryboard: UIStoryboard {\n
\t\t        return UIStoryboard(name: "\"Main\"", bundle: .none)\n
\t    }\n
}
"
echo $ASSEMBLY_CONTENT>$ASSEMBLY_FILENAME

#Presenter
PRESENTER_FILENAME="$1Presenter.swift"
PRESENTER_CONTENT="
class $1Presenter: $1PresenterProtocol {\n
\t    weak var view: $1ViewProtocol?\n
\t    var wireframe: $1WireframeProtocol?\n
\t    var interactor: $1InteractorProtocol?\n
\n   
\t    func viewDidLoad() {\n
\t\n        
\t    }\n
}
"
echo $PRESENTER_CONTENT>$PRESENTER_FILENAME

# Tests (using Quick/Nimble)
mkdir Tests

# Assembly
ASSEMBLY_TESTS_FILENAME="Tests/$1AssemblyTests.swift"
ASSEMBLY_TESTS_CONTENT="
import Quick\n
import Nimble\n
@testable import ProjectName\n
\n
class $1AssemblySpec: QuickSpec {\n
\t    override func spec() {\n
\t\t        describe(\"$1 module\") {\n
\t\t\t\n            
\t\t\t            let viewController = $1Assembly.create$1Module()\n
\t\t\t\n            
\t\t\t            it(\"contains fully initialized presenter\") {\n
\t\t\t\t                expect(viewController).to(beAKindOf($1View.self))\n
\t\t\t\t\n                
\t\t\t\t                let presenter = (viewController as? $1View)?.presenter\n
\t\t\t\t                let interactor = presenter?.interactor\n
\t\t\t\t\n                
\t\t\t\t                expect(presenter).notTo(beNil())\n
\t\t\t\t                expect(interactor).notTo(beNil())\n
\t\t\t\t                expect(presenter?.wireframe).notTo(beNil())\n
\t\t\t\t                expect(presenter?.view).notTo(beNil())\n
\t\t\t            }\n
\t\t        }\n
\t    }\n
}
"
echo $ASSEMBLY_TESTS_CONTENT>$ASSEMBLY_TESTS_FILENAME

# Interactor
INTERACTOR_TESTS_FILENAME="Tests/$1InteractorTests.swift"
INTERACTOR_TESTS_CONTENT="
@testable import ProjectName\n
import Quick\n
import Nimble\n
\n
class $1InteractorSpec: QuickSpec {\n
\n
\toverride func spec() {\n
\t\t\n
\t}\n
}
"
echo $INTERACTOR_TESTS_CONTENT>$INTERACTOR_TESTS_FILENAME

# Presenter
PRESENTER_TESTS_FILENAME="Tests/$1PresenterTests.swift"
PRESENTER_TESTS_CONTENT="
@testable import ProjectName\n
import Quick\n
import Nimble\n
\n
class $1PresenterSpec: QuickSpec {\n
\n
\toverride func spec() {\n
\t\t\n
\t}\n
}
"
echo $PRESENTER_TESTS_CONTENT>$PRESENTER_TESTS_FILENAME

# Wireframe
WIREFRAME_TESTS_FILENAME="Tests/$1WireframeTests.swift"
WIREFRAME_TESTS_CONTENT="
@testable import ProjectName\n
import Quick\n
import Nimble\n
\n
class $1WireframeSpec: QuickSpec {\n
\n
\toverride func spec() {\n
\t\t\n
\t}\n
}
"
echo $WIREFRAME_TESTS_CONTENT>$WIREFRAME_TESTS_FILENAME


