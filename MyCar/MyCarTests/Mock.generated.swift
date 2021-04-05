// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.1

import SwiftyMocky
import XCTest
import Foundation
import RxSwift
@testable import MyCar


// MARK: - CarAPIType

open class CarAPITypeMock: CarAPIType, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var networkClient: NetworkClientType {
		get {	invocations.append(.p_networkClient_get); return __p_networkClient ?? givenGetterValue(.p_networkClient_get, "CarAPITypeMock - stub value for networkClient was not defined") }
	}
	private var __p_networkClient: (NetworkClientType)?





    open func fetchManufacturers(page: Int) -> PublishSubject<ManufacturerResponse> {
        addInvocation(.m_fetchManufacturers__page_page(Parameter<Int>.value(`page`)))
		let perform = methodPerformValue(.m_fetchManufacturers__page_page(Parameter<Int>.value(`page`))) as? (Int) -> Void
		perform?(`page`)
		var __value: PublishSubject<ManufacturerResponse>
		do {
		    __value = try methodReturnValue(.m_fetchManufacturers__page_page(Parameter<Int>.value(`page`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchManufacturers(page: Int). Use given")
			Failure("Stub return value not specified for fetchManufacturers(page: Int). Use given")
		}
		return __value
    }

    open func fetchCarModels(page: Int, manufacturerID: String) -> PublishSubject<CarModelResponse> {
        addInvocation(.m_fetchCarModels__page_pagemanufacturerID_manufacturerID(Parameter<Int>.value(`page`), Parameter<String>.value(`manufacturerID`)))
		let perform = methodPerformValue(.m_fetchCarModels__page_pagemanufacturerID_manufacturerID(Parameter<Int>.value(`page`), Parameter<String>.value(`manufacturerID`))) as? (Int, String) -> Void
		perform?(`page`, `manufacturerID`)
		var __value: PublishSubject<CarModelResponse>
		do {
		    __value = try methodReturnValue(.m_fetchCarModels__page_pagemanufacturerID_manufacturerID(Parameter<Int>.value(`page`), Parameter<String>.value(`manufacturerID`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchCarModels(page: Int, manufacturerID: String). Use given")
			Failure("Stub return value not specified for fetchCarModels(page: Int, manufacturerID: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_fetchManufacturers__page_page(Parameter<Int>)
        case m_fetchCarModels__page_pagemanufacturerID_manufacturerID(Parameter<Int>, Parameter<String>)
        case p_networkClient_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetchManufacturers__page_page(let lhsPage), .m_fetchManufacturers__page_page(let rhsPage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchCarModels__page_pagemanufacturerID_manufacturerID(let lhsPage, let lhsManufacturerid), .m_fetchCarModels__page_pagemanufacturerID_manufacturerID(let rhsPage, let rhsManufacturerid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsManufacturerid, rhs: rhsManufacturerid, with: matcher), lhsManufacturerid, rhsManufacturerid, "manufacturerID"))
				return Matcher.ComparisonResult(results)
            case (.p_networkClient_get,.p_networkClient_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fetchManufacturers__page_page(p0): return p0.intValue
            case let .m_fetchCarModels__page_pagemanufacturerID_manufacturerID(p0, p1): return p0.intValue + p1.intValue
            case .p_networkClient_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetchManufacturers__page_page: return ".fetchManufacturers(page:)"
            case .m_fetchCarModels__page_pagemanufacturerID_manufacturerID: return ".fetchCarModels(page:manufacturerID:)"
            case .p_networkClient_get: return "[get] .networkClient"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func networkClient(getter defaultValue: NetworkClientType...) -> PropertyStub {
            return Given(method: .p_networkClient_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func fetchManufacturers(page: Parameter<Int>, willReturn: PublishSubject<ManufacturerResponse>...) -> MethodStub {
            return Given(method: .m_fetchManufacturers__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchCarModels(page: Parameter<Int>, manufacturerID: Parameter<String>, willReturn: PublishSubject<CarModelResponse>...) -> MethodStub {
            return Given(method: .m_fetchCarModels__page_pagemanufacturerID_manufacturerID(`page`, `manufacturerID`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchManufacturers(page: Parameter<Int>, willProduce: (Stubber<PublishSubject<ManufacturerResponse>>) -> Void) -> MethodStub {
            let willReturn: [PublishSubject<ManufacturerResponse>] = []
			let given: Given = { return Given(method: .m_fetchManufacturers__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (PublishSubject<ManufacturerResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func fetchCarModels(page: Parameter<Int>, manufacturerID: Parameter<String>, willProduce: (Stubber<PublishSubject<CarModelResponse>>) -> Void) -> MethodStub {
            let willReturn: [PublishSubject<CarModelResponse>] = []
			let given: Given = { return Given(method: .m_fetchCarModels__page_pagemanufacturerID_manufacturerID(`page`, `manufacturerID`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (PublishSubject<CarModelResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetchManufacturers(page: Parameter<Int>) -> Verify { return Verify(method: .m_fetchManufacturers__page_page(`page`))}
        public static func fetchCarModels(page: Parameter<Int>, manufacturerID: Parameter<String>) -> Verify { return Verify(method: .m_fetchCarModels__page_pagemanufacturerID_manufacturerID(`page`, `manufacturerID`))}
        public static var networkClient: Verify { return Verify(method: .p_networkClient_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetchManufacturers(page: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_fetchManufacturers__page_page(`page`), performs: perform)
        }
        public static func fetchCarModels(page: Parameter<Int>, manufacturerID: Parameter<String>, perform: @escaping (Int, String) -> Void) -> Perform {
            return Perform(method: .m_fetchCarModels__page_pagemanufacturerID_manufacturerID(`page`, `manufacturerID`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - ResponseDecoderType

open class ResponseDecoderTypeMock: ResponseDecoderType, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func decode<ResponseType: Decodable>(responseData: Data) throws -> ResponseType {
        addInvocation(.m_decode__responseData_responseData(Parameter<Data>.value(`responseData`)))
		let perform = methodPerformValue(.m_decode__responseData_responseData(Parameter<Data>.value(`responseData`))) as? (Data) -> Void
		perform?(`responseData`)
		var __value: ResponseType
		do {
		    __value = try methodReturnValue(.m_decode__responseData_responseData(Parameter<Data>.value(`responseData`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for decode<ResponseType: Decodable>(responseData: Data). Use given")
			Failure("Stub return value not specified for decode<ResponseType: Decodable>(responseData: Data). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_decode__responseData_responseData(Parameter<Data>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_decode__responseData_responseData(let lhsResponsedata), .m_decode__responseData_responseData(let rhsResponsedata)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsResponsedata, rhs: rhsResponsedata, with: matcher), lhsResponsedata, rhsResponsedata, "responseData"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_decode__responseData_responseData(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_decode__responseData_responseData: return ".decode(responseData:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func decode<ResponseType: Decodable>(responseData: Parameter<Data>, willReturn: ResponseType...) -> MethodStub {
            return Given(method: .m_decode__responseData_responseData(`responseData`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func decode(responseData: Parameter<Data>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_decode__responseData_responseData(`responseData`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func decode<ResponseType: Decodable>(responseData: Parameter<Data>, willProduce: (StubberThrows<ResponseType>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_decode__responseData_responseData(`responseData`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (ResponseType).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func decode(responseData: Parameter<Data>) -> Verify { return Verify(method: .m_decode__responseData_responseData(`responseData`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func decode(responseData: Parameter<Data>, perform: @escaping (Data) -> Void) -> Perform {
            return Perform(method: .m_decode__responseData_responseData(`responseData`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

