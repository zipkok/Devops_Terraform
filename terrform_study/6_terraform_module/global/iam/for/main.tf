provider "aws" {
  region = "ap-northeast-2"
}

/*
리스트를 반복하고 리스트로 출력
[for <ITEM> in <LIST> : <OUTPUT> ]
*/

variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

# Result: short_upper_names = [ "NEO", ]
output "short_upper_names" {
  value = [for name in var.names : upper(name) if length(name) < 5]
}


/*
맵을 반복하고 리스트로 출력
[for <KEY>, <VALUE> in <MAP> : <OUTPUT>]
*/

variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default = {
    neo      = "hero"
    trinity  = "love interest"
    morpheus = "mentor"
  }
}

# Result: bios = [ "neo is the hero", "trinity is the love interest", "morpheus is the mentor" ]
output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}


/* 
리스트를 반복하고 맵을 출력
[for <ITEM> in <LIST> : <OUTPUT_KEY> => <OUTPUT_VALUE> ]

맵을 반복하고 리스트를 출력
{ for <KEY>, <VALUE> in <MAP> : <OUTPUT_KEY> => <OUTPUT_VALUE> }
*/
variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default = {
    neo      = "hero"
    trinity  = "love interest"
    morpheus = "mentor"
  }
}

# Result: upper_roles = {   
#                           "MORPHEUS"  = "MENTOR"
#                           "NEO"       = "HERO"
#                           "trinity"   = "LOVE INTEREST"
#                       }
output "upper_roles" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}
