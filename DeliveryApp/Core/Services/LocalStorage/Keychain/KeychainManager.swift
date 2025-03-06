import Foundation
import Security

protocol KeychainService {
    func save(key: String, value: String)
    func retrieve(key: String) -> String?
    func delete(key: String)
}

final class KeychainManager: KeychainService {
    func save(key: String, value: String) {
        guard let data = value.data(using: .utf8) else {
            print(KeychainError.invalidData.message)
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print(KeychainError.keychainError(status).message)
        }
    }
    
    func retrieve(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data, let string = String(data: data, encoding: .utf8) {
            return string
        } else if status == errSecItemNotFound {
            print(KeychainError.itemNotFound.message)
            return nil
        } else {
            print(KeychainError.keychainError(status).message)
            return nil
        }
    }
    
    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess && status != errSecItemNotFound {
            print(KeychainError.keychainError(status).message)
        }
    }
}

extension KeychainManager {
    enum KeychainError: Error {
        case invalidData
        case itemNotFound
        case keychainError(OSStatus)

        var message: String {
            switch self {
            case .invalidData:
                return "Os dados fornecidos não puderam ser convertidos para Data."
            case .itemNotFound:
                return "O item solicitado não foi encontrado no Keychain."
            case .keychainError(let status):
                if let message = SecCopyErrorMessageString(status, nil) {
                    return "Erro do Keychain: \(message)"
                } else {
                    return "Erro desconhecido do Keychain (código: \(status))."
                }
            }
        }
    }
}
