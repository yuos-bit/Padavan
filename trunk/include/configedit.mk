# This function sets a kconfig option to a specific value in a .config file
# Usage: KconfigSetOption <option> <value> <file>
define KconfigSetOption
	@grep -E -q '^$(1)=.*' '$(3)' && \
	sed -i -r -e 's;^$(1)=.*$$;$(1)=$(2);' '$(3)' || \
	grep -E -q '^# $(1) is not set$$' '$(3)' && \
	sed -i -r -e 's;^# $(1) is not set$$;$(1)=$(2);' '$(3)' || \
	echo '$(1)=$(2)' >> '$(3)'
endef


# This function enables a kconfig option to '=y' in a .config file
# Usage: KconfigEnableOption <option> <file>
define KconfigEnableOption
	$(call KconfigSetOption,$(1),y,$(2))
endef

# This function disables a kconfig option in a .config file
# Usage: KconfigDisableOption <option> <file>
define KconfigDisableOption
	@grep -E -q '^# $(1) is not set$$' '$(2)' || \
	grep -E -q '^$(1)=.*$$' '$(2)' && \
	sed -i -r -e 's;^$(1)=.*$$;# $(1) is not set;' '$(2)' || \
	echo '# $(1) is not set' >> '$(2)'
endef

# This function deletes a kconfig option in a .config file, no matter if it
# is set or commented out.
# Usage: KconfigDeleteOption <option> <file>
define KconfigDeleteOption
	@grep -E -q '^# $(1) is not set$$' '$(2)' && \
	sed -i -r -e '/^# $(1) is not set$$/d' '$(2)' || \
	grep -E -q '^$(1)=.*$$' '$(2)' && \
	sed -i -r -e '/^$(1)=.*$$/d' '$(2)' || true
endef
