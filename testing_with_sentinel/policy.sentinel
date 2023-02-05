import "tfconfig/v2" as conf

# Define tags that need to be on the  resource
mandatory_tags = ["project", "owner"]

# count resources with missing tags
invalid_resources = conf.filter_attribute_not_contains_list(
    conf.resources, "tags", mandatory_tags, true)


main = rule {
    invalid_resources == 0
}