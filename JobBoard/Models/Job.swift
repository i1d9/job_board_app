//
//  Job.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


struct Job : Codable, Identifiable{
    
    var id : Int
    var name : String
    var description : String
    var company : Company? = nil
    var type : String //Contract/Long Term/Short Term/Internship/Consultancy
    var environment : String //Remote/Semi-remote/In-Office
    var status : String
    
    init(id: Int, name : String, description: String, type: String, environment: String, status: String){
        self.id = id
        self.name = name
        self.description = description
        self.type = type
        self.environment = environment
        self.status = status
    }
    
    
    private enum JobDataKeys: String, CodingKey {
        case id = "id",attributes = "attributes"
        
        
        enum AttributeKeys : String, CodingKey {
            case name = "name",description = "description",company = "company",type="type",environment = "environment", status = "status"
            
            
            enum CompanyKey : String, CodingKey{
                case data = "data"
                enum CompanyDataKeys : String, CodingKey {
                    case id = "id", attributes = "attributes"
                    
                    enum CompanyDataAttributesKeys : String, CodingKey{
                        case address = "address",bio = "bio",category = "category",email = "email", name = "name", phone = "phone",
                             logo = "logo"
                        
                        enum CompanyLogoKey : String, CodingKey{
                            case data = "data"
                            
                            enum CompanyLogoAttributes : String, CodingKey {
                                case attributes = "attributes"
                                
                                enum CompanyLogoAttributeKeys : String, CodingKey {
                                    case url = "url", formats = "formats"
                                    
                                    enum CompanyLogoAttributeFormatsKeys : String, CodingKey {
                                        
                                        case large = "large", medium = "medium", small = "small", thumbnail = "thumbnail", url = "url"
                                        
                                        enum CompanyLogoFormartsLarge: String, CodingKey{
                                            case url = "url"
                                        }
                                        
                                        enum CompanyLogoFormartsThumbnail: String, CodingKey{
                                            case url = "url"
                                        }
                                        
                                        enum CompanyLogoFormartsSmall: String, CodingKey{
                                            case url = "url"
                                        }
                                        
                                        
                                        enum CompanyLogoFormartsMedium: String, CodingKey{
                                            case url = "url"
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        
        
        let jobDataKeysContainer = try decoder.container(keyedBy: JobDataKeys.self)
        
        self.id = try jobDataKeysContainer.decode(Int.self, forKey: .id)
        
        
        let attributesContainer = try jobDataKeysContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.self, forKey: .attributes)
        
        self.name = try attributesContainer.decode(String.self, forKey: .name)
        self.description = try attributesContainer.decode(String.self, forKey: .description)
        self.type = try attributesContainer.decode(String.self, forKey: .type)
        self.environment = try attributesContainer.decode(String.self, forKey: .environment)
        self.status = try attributesContainer.decode(String.self, forKey: .status)
        
        let companyContainer = try attributesContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.self, forKey: .company)
        let companyDataContainer = try companyContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.self, forKey: .data)
        
        let company_id = try companyDataContainer.decode(Int.self, forKey: .id)
        
        
        let companyDataAttributesContainer = try companyDataContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.self, forKey: .attributes)
        
        let company_address = try companyDataAttributesContainer.decode(String.self, forKey: .address)
        let company_bio = try companyDataAttributesContainer.decode(String.self, forKey: .bio)
        let company_category = try companyDataAttributesContainer.decode(String.self, forKey: .category)
        let company_name = try companyDataAttributesContainer.decode(String.self, forKey: .name)
        let company_phone = try companyDataAttributesContainer.decode(String.self, forKey: .phone)
        let company_email = try companyDataAttributesContainer.decode(String.self, forKey: .email)
        
        
        let companyLogoRootContainer = try companyDataAttributesContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.CompanyLogoKey.self, forKey: .logo)
        
        
        let companyLogoDataContainer = try companyLogoRootContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.CompanyLogoKey.CompanyLogoAttributes.self, forKey: .data)
        
        let companyLogoDataAttributesContainer = try companyLogoDataContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.CompanyLogoKey.CompanyLogoAttributes.CompanyLogoAttributeKeys.self, forKey: .attributes)
        
        let logo_url = try companyLogoDataAttributesContainer.decode(String.self, forKey: .url)
        
        let companyLogoDataAttributesKeysFormatContainer = try companyLogoDataAttributesContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.CompanyLogoKey.CompanyLogoAttributes.CompanyLogoAttributeKeys.CompanyLogoAttributeFormatsKeys.self, forKey: .formats)
        
        let companyLogoDataAttributesKeysFormatLargeContainer = try companyLogoDataAttributesKeysFormatContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.CompanyLogoKey.CompanyLogoAttributes.CompanyLogoAttributeKeys.CompanyLogoAttributeFormatsKeys.CompanyLogoFormartsLarge.self, forKey: .large)
        
        let companyLogoDataAttributesKeysFormatSmallContainer = try companyLogoDataAttributesKeysFormatContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.CompanyLogoKey.CompanyLogoAttributes.CompanyLogoAttributeKeys.CompanyLogoAttributeFormatsKeys.CompanyLogoFormartsSmall.self, forKey: .small)
        
        let companyLogoDataAttributesKeysFormatMediumContainer = try companyLogoDataAttributesKeysFormatContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.CompanyLogoKey.CompanyLogoAttributes.CompanyLogoAttributeKeys.CompanyLogoAttributeFormatsKeys.CompanyLogoFormartsMedium.self, forKey: .medium)
        
        let companyLogoDataAttributesKeysFormatThumbnailContainer = try companyLogoDataAttributesKeysFormatContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.CompanyKey.CompanyDataKeys.CompanyDataAttributesKeys.CompanyLogoKey.CompanyLogoAttributes.CompanyLogoAttributeKeys.CompanyLogoAttributeFormatsKeys.CompanyLogoFormartsThumbnail.self, forKey: .thumbnail)
        
        let thumbnail = try companyLogoDataAttributesKeysFormatThumbnailContainer.decode(String.self, forKey: .url)
        let medium = try companyLogoDataAttributesKeysFormatMediumContainer.decode(String.self, forKey: .url)
        let large = try companyLogoDataAttributesKeysFormatLargeContainer.decode(String.self, forKey: .url)
        let small = try companyLogoDataAttributesKeysFormatSmallContainer.decode(String.self, forKey: .url)
        let company_logo = CompanyLogo(url: logo_url, thumbnail: thumbnail, small: small, medium: medium, large: large)
        
        self.company = Company(id: company_id, name: company_name, phone: company_phone, email: company_email, address: company_address, category: company_category, bio: company_bio, logo: company_logo)
        
    }
    
}

struct MyCompanyJob: Codable, Identifiable{
    
    
    
    
    var id : Int
    var name : String
    var status : String
    var type : String
    var description: String
    var environment : String
    var applications : [MyCompanyApplication]
    init(id: Int, name: String, status:String, type:String, description:String, environment:String) {
        
        self.id = id
        self.name = name
        self.status = status
        self.type = type
        self.description = description
        self.environment = environment
        self.applications = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        self.type = try container.decode(String.self, forKey: .type)
        self.description = try container.decode(String.self, forKey: .description)
        self.environment = try container.decode(String.self, forKey: .environment)
        self.applications = try container.decode([MyCompanyApplication].self, forKey: .applications)
    }
}
