# SPDX-License-Identifier: GPL-2.0
dtb-y += exynos/exynos9610.dtb

dtb-$(CONFIG_MACH_EXYNOS9611_M30S_OPEN) := \
        samsung/exynos9611-m30s_chn_open_00.dtbo \
        samsung/exynos9611-m30s_chn_open_02.dtbo \
        samsung/exynos9611-m30s_chn_open_03.dtbo \
        samsung/exynos9611-m30s_chn_open_04.dtbo \
        samsung/exynos9611-m30s_swa_open_00.dtbo \
        samsung/exynos9611-m30s_swa_open_02.dtbo \
        samsung/exynos9611-m30s_swa_open_03.dtbo \
        samsung/exynos9611-m30s_swa_open_04.dtbo

ifeq ($(CONFIG_MACH_EXYNOS9611_M30S_OPEN),y)
always         := $(dtb-y) $(dtbo-y)
clean-files    := *.dtb *.dtbo
endif
