src_dir          := scripts
data_dir         := data
edit_scripts_dir := Edit Scripts
csvs_dir         := Skyrim Enchantments CSVs
name             := xEditEnchant
dist_dir         := dist
release          := $(dist_dir)/$(name)-$(shell git describe --always --dirty).zip

all: bbcode release

bbcode: description.bbcode

release: $(release)

$(release):
	@mkdir -p "$(dist_dir)" "$(edit_scripts_dir)" "$(csvs_dir)"
	@cp $(src_dir)/*.pas "$(edit_scripts_dir)"
	@cp $(data_dir)/*.csv "$(csvs_dir)"
	@zip $@ "$(edit_scripts_dir)"/*.pas "$(csvs_dir)"/*.csv
	@rm -rf "$(edit_scripts_dir)" "$(csvs_dir)"

%.bbcode: %.md
	@pandoc-bbcode_nexus $< -o $@

clean:
	@rm -rfv "$(edit_scripts_dir)" "$(csvs_dir)" $(release) $(name)*.zip

.PHONY: all clean test release bbcode
