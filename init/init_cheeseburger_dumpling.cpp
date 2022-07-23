/*
   Copyright (C) 2017 - 2022 The Android Open Source Project

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>

#include <android-base/properties.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "property_service.h"
#include "vendor_init.h"

using std::string;

void property_override(string prop, string value)
{
    auto pi = (prop_info*) __system_property_find(prop.c_str());

    if (pi != nullptr)
        __system_property_update(pi, value.c_str(), value.size());
    else
        __system_property_add(prop.c_str(), prop.size(), value.c_str(), value.size());
}

void model_property_override(const std::string& name, const std::string& device, const std::string& model,const std::string& fingerprint)
{
    property_override("ro.product.name", name);
    property_override("ro.product.odm.name", name);
    property_override("ro.product.system.name", name);
    property_override("ro.product.vendor.name", name);
    property_override("ro.product.system_ext.name", name);
    property_override("ro.product.device", device);
    property_override("ro.product.odm.device", device);
    property_override("ro.product.system.device", device);
    property_override("ro.product.vendor.device", device);
    property_override("ro.product.system_ext.device", device);
    property_override("ro.product.model", model);
    property_override("ro.product.odm.model", model);
    property_override("ro.product.system.model", model);
    property_override("ro.product.vendor.model", model);
    property_override("ro.product.system_ext.model", model);
    property_override("ro.odm.build.fingerprint", fingerprint);
    property_override("ro.system.build.fingerprint", fingerprint);
    property_override("ro.system_ext.build.fingerprint", fingerprint);
    property_override("ro.vendor.build.fingerprint", fingerprint);
}

void vendor_load_properties()
{
	int rf_version = stoi(android::base::GetProperty("ro.boot.rf_version", ""));

	switch (rf_version) {
	/* OnePlus 5 */
	case 53:
    model_property_override("OnePlus5", "cheeseburger", "OnePlus A5000", "OnePlus/OnePlus5/OnePlus5:10/QKQ1.191014.012/2010292059:user/release-keys");
		break;
	/* OnePlus 5T */
	case 21:
	  model_property_override("OnePlus5T", "dumpling", "OnePlus A5010", "OnePlus/OnePlus5T/OnePlus5T:10/QKQ1.191014.012/2010292059:user/release-keys");
		break;
	/* default to OnePlus 5 */
	default:
		model_property_override("OnePlus5", "cheeseburger", "OnePlus A5000", "OnePlus/OnePlus5/OnePlus5:10/QKQ1.191014.012/2010292059:user/release-keys");
	}
}
