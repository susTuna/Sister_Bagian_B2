#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/sysinfo.h>
#include <sys/utsname.h>
#include <sys/statvfs.h>
#include <ifaddrs.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>

// Output format options
typedef enum {
    FORMAT_TEXT,
    FORMAT_JSON,
    FORMAT_HTML
} OutputFormat;

// Function prototypes
void print_usage(const char *program_name);
void print_system_info(OutputFormat format);
void print_memory_info(OutputFormat format);
void print_cpu_info(OutputFormat format);
void print_network_info(OutputFormat format);
void print_disk_info(OutputFormat format);
void print_header(OutputFormat format, const char *title);
void print_footer(OutputFormat format);

int main(int argc, char *argv[]) {
    OutputFormat format = FORMAT_TEXT;
    int info_type = 0;  // 0 = all, 1 = system, 2 = memory, 3 = cpu, 4 = network, 5 = disk
    
    // Parse command line arguments
    if (argc > 1) {
        for (int i = 1; i < argc; i++) {
            if (strcmp(argv[i], "--json") == 0) {
                format = FORMAT_JSON;
            } else if (strcmp(argv[i], "--html") == 0) {
                format = FORMAT_HTML;
            } else if (strcmp(argv[i], "--system") == 0) {
                info_type = 1;
            } else if (strcmp(argv[i], "--memory") == 0) {
                info_type = 2;
            } else if (strcmp(argv[i], "--cpu") == 0) {
                info_type = 3;
            } else if (strcmp(argv[i], "--network") == 0) {
                info_type = 4;
            } else if (strcmp(argv[i], "--disk") == 0) {
                info_type = 5;
            } else if (strcmp(argv[i], "--help") == 0) {
                print_usage(argv[0]);
                return 0;
            }
        }
    }

    // Print header based on format
    if (format == FORMAT_JSON) {
        printf("{\n");
    } else if (format == FORMAT_HTML) {
        printf("<!DOCTYPE html>\n<html>\n<head>\n<title>System Information</title>\n");
        printf("<style>\n");
        printf("  body { font-family: Arial, sans-serif; margin: 20px; }\n");
        printf("  h1 { color: #333; }\n");
        printf("  h2 { color: #555; margin-top: 20px; }\n");
        printf("  table { border-collapse: collapse; width: 100%%; }\n");
        printf("  th, td { text-align: left; padding: 8px; border-bottom: 1px solid #ddd; }\n");
        printf("  th { background-color: #f2f2f2; }\n");
        printf("  tr:hover { background-color: #f5f5f5; }\n");
        printf("</style>\n</head>\n<body>\n");
        printf("<h1>System Information</h1>\n");
    }

    // Display requested information
    switch (info_type) {
        case 0: // All
            print_system_info(format);
            print_memory_info(format);
            print_cpu_info(format);
            print_network_info(format);
            print_disk_info(format);
            break;
        case 1:
            print_system_info(format);
            break;
        case 2:
            print_memory_info(format);
            break;
        case 3:
            print_cpu_info(format);
            break;
        case 4:
            print_network_info(format);
            break;
        case 5:
            print_disk_info(format);
            break;
    }

    // Print footer
    print_footer(format);
    
    return 0;
}

void print_usage(const char *program_name) {
    printf("Usage: %s [OPTIONS]\n\n", program_name);
    printf("Options:\n");
    printf("  --json       Output in JSON format\n");
    printf("  --html       Output in HTML format\n");
    printf("  --system     Show only system information\n");
    printf("  --memory     Show only memory information\n");
    printf("  --cpu        Show only CPU information\n");
    printf("  --network    Show only network information\n");
    printf("  --disk       Show only disk information\n");
    printf("  --help       Show this help message\n");
}

void print_header(OutputFormat format, const char *title) {
    if (format == FORMAT_TEXT) {
        printf("\n===== %s =====\n", title);
    } else if (format == FORMAT_JSON) {
        printf("  \"%s\": {\n", title);
    } else if (format == FORMAT_HTML) {
        printf("<h2>%s</h2>\n<table>\n", title);
        printf("<tr><th>Property</th><th>Value</th></tr>\n");
    }
}

void print_footer(OutputFormat format) {
    if (format == FORMAT_JSON) {
        printf("}\n");
    } else if (format == FORMAT_HTML) {
        printf("</body>\n</html>\n");
    }
}

void print_system_info(OutputFormat format) {
    struct utsname system_info;
    time_t current_time;
    char time_str[100];
    
    uname(&system_info);
    time(&current_time);
    strftime(time_str, sizeof(time_str), "%Y-%m-%d %H:%M:%S", localtime(&current_time));
    
    print_header(format, "System Information");
    
    if (format == FORMAT_TEXT) {
        printf("System Name:    %s\n", system_info.sysname);
        printf("Node Name:      %s\n", system_info.nodename);
        printf("Release:        %s\n", system_info.release);
        printf("Version:        %s\n", system_info.version);
        printf("Machine:        %s\n", system_info.machine);
        printf("Current Time:   %s\n", time_str);
    } else if (format == FORMAT_JSON) {
        printf("    \"sysname\": \"%s\",\n", system_info.sysname);
        printf("    \"nodename\": \"%s\",\n", system_info.nodename);
        printf("    \"release\": \"%s\",\n", system_info.release);
        printf("    \"version\": \"%s\",\n", system_info.version);
        printf("    \"machine\": \"%s\",\n", system_info.machine);
        printf("    \"time\": \"%s\"\n  },\n", time_str);
    } else if (format == FORMAT_HTML) {
        printf("<tr><td>System Name</td><td>%s</td></tr>\n", system_info.sysname);
        printf("<tr><td>Node Name</td><td>%s</td></tr>\n", system_info.nodename);
        printf("<tr><td>Release</td><td>%s</td></tr>\n", system_info.release);
        printf("<tr><td>Version</td><td>%s</td></tr>\n", system_info.version);
        printf("<tr><td>Machine</td><td>%s</td></tr>\n", system_info.machine);
        printf("<tr><td>Current Time</td><td>%s</td></tr>\n", time_str);
        printf("</table>\n");
    }
}

void print_memory_info(OutputFormat format) {
    struct sysinfo mem_info;
    sysinfo(&mem_info);
    
    // Convert to more readable units
    double total_ram = mem_info.totalram / (1024.0 * 1024.0 * 1024.0); // GB
    double free_ram = mem_info.freeram / (1024.0 * 1024.0 * 1024.0);   // GB
    double used_ram = total_ram - free_ram;
    double ram_usage = (used_ram / total_ram) * 100.0;
    
    print_header(format, "Memory Information");
    
    if (format == FORMAT_TEXT) {
        printf("Total RAM:      %.2f GB\n", total_ram);
        printf("Free RAM:       %.2f GB\n", free_ram);
        printf("Used RAM:       %.2f GB\n", used_ram);
        printf("RAM Usage:      %.2f%%\n", ram_usage);
        printf("Total Swap:     %.2f GB\n", mem_info.totalswap / (1024.0 * 1024.0 * 1024.0));
        printf("Free Swap:      %.2f GB\n", mem_info.freeswap / (1024.0 * 1024.0 * 1024.0));
    } else if (format == FORMAT_JSON) {
        printf("    \"total_ram\": %.2f,\n", total_ram);
        printf("    \"free_ram\": %.2f,\n", free_ram);
        printf("    \"used_ram\": %.2f,\n", used_ram);
        printf("    \"ram_usage\": %.2f,\n", ram_usage);
        printf("    \"total_swap\": %.2f,\n", mem_info.totalswap / (1024.0 * 1024.0 * 1024.0));
        printf("    \"free_swap\": %.2f\n  },\n", mem_info.freeswap / (1024.0 * 1024.0 * 1024.0));
    } else if (format == FORMAT_HTML) {
        printf("<tr><td>Total RAM</td><td>%.2f GB</td></tr>\n", total_ram);
        printf("<tr><td>Free RAM</td><td>%.2f GB</td></tr>\n", free_ram);
        printf("<tr><td>Used RAM</td><td>%.2f GB</td></tr>\n", used_ram);
        printf("<tr><td>RAM Usage</td><td>%.2f%%</td></tr>\n", ram_usage);
        printf("<tr><td>Total Swap</td><td>%.2f GB</td></tr>\n", mem_info.totalswap / (1024.0 * 1024.0 * 1024.0));
        printf("<tr><td>Free Swap</td><td>%.2f GB</td></tr>\n", mem_info.freeswap / (1024.0 * 1024.0 * 1024.0));
        printf("</table>\n");
    }
}

void print_cpu_info(OutputFormat format) {
    FILE *cpuinfo = fopen("/proc/cpuinfo", "r");
    char line[256];
    char model_name[256] = "Unknown";
    int cpu_cores = 0;
    
    if (cpuinfo) {
        while (fgets(line, sizeof(line), cpuinfo)) {
            if (strncmp(line, "model name", 10) == 0) {
                char *p = strchr(line, ':');
                if (p) {
                    p++; // Skip the colon
                    while (*p == ' ') p++; // Skip spaces
                    strncpy(model_name, p, sizeof(model_name) - 1);
                    // Remove newline
                    char *nl = strchr(model_name, '\n');
                    if (nl) *nl = '\0';
                }
            }
            if (strncmp(line, "processor", 9) == 0) {
                cpu_cores++;
            }
        }
        fclose(cpuinfo);
    }
    
    print_header(format, "CPU Information");
    
    if (format == FORMAT_TEXT) {
        printf("CPU Model:      %s\n", model_name);
        printf("CPU Cores:      %d\n", cpu_cores);
    } else if (format == FORMAT_JSON) {
        printf("    \"cpu_model\": \"%s\",\n", model_name);
        printf("    \"cpu_cores\": %d\n  },\n", cpu_cores);
    } else if (format == FORMAT_HTML) {
        printf("<tr><td>CPU Model</td><td>%s</td></tr>\n", model_name);
        printf("<tr><td>CPU Cores</td><td>%d</td></tr>\n", cpu_cores);
        printf("</table>\n");
    }
}

void print_network_info(OutputFormat format) {
    struct ifaddrs *ifaddr, *ifa;
    int family, s;
    char host[NI_MAXHOST];
    
    print_header(format, "Network Information");
    
    if (getifaddrs(&ifaddr) == -1) {
        if (format == FORMAT_TEXT) {
            printf("Error getting network interfaces\n");
        } else if (format == FORMAT_JSON) {
            printf("    \"error\": \"Could not get network interfaces\"\n  },\n");
        } else if (format == FORMAT_HTML) {
            printf("<tr><td>Error</td><td>Could not get network interfaces</td></tr>\n</table>\n");
        }
        return;
    }
    
    // For JSON, we need to handle the array structure
    if (format == FORMAT_JSON) {
        printf("    \"interfaces\": [\n");
    }
    
    // Walk through linked list, maintaining head pointer so we can free list later
    int first = 1;
    for (ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
        if (ifa->ifa_addr == NULL) {
            continue;
        }
        
        family = ifa->ifa_addr->sa_family;
        
        // For IPv4 or IPv6 addresses
        if (family == AF_INET || family == AF_INET6) {
            s = getnameinfo(ifa->ifa_addr,
                           (family == AF_INET) ? sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6),
                           host, NI_MAXHOST, NULL, 0, NI_NUMERICHOST);
                           
            if (s != 0) {
                continue;
            }
            
            if (format == FORMAT_TEXT) {
                printf("Interface:      %s\n", ifa->ifa_name);
                printf("Address:        %s\n", host);
                printf("Family:         %s\n\n", (family == AF_INET) ? "IPv4" : "IPv6");
            } else if (format == FORMAT_JSON) {
                if (!first) printf(",\n");
                first = 0;
                printf("      {\n");
                printf("        \"name\": \"%s\",\n", ifa->ifa_name);
                printf("        \"address\": \"%s\",\n", host);
                printf("        \"family\": \"%s\"\n", (family == AF_INET) ? "IPv4" : "IPv6");
                printf("      }");
            } else if (format == FORMAT_HTML) {
                printf("<tr><td>Interface</td><td>%s</td></tr>\n", ifa->ifa_name);
                printf("<tr><td>Address</td><td>%s</td></tr>\n", host);
                printf("<tr><td>Family</td><td>%s</td></tr>\n", (family == AF_INET) ? "IPv4" : "IPv6");
                printf("<tr><td colspan=\"2\">&nbsp;</td></tr>\n");
            }
        }
    }
    
    freeifaddrs(ifaddr);
    
    if (format == FORMAT_JSON) {
        printf("\n    ]\n  },\n");
    } else if (format == FORMAT_HTML) {
        printf("</table>\n");
    }
}

void print_disk_info(OutputFormat format) {
    struct statvfs stat;
    
    if (statvfs("/", &stat) != 0) {
        if (format == FORMAT_TEXT) {
            printf("Error getting disk information\n");
        } else if (format == FORMAT_JSON) {
            printf("    \"error\": \"Could not get disk information\"\n  }\n");
        } else if (format == FORMAT_HTML) {
            printf("<tr><td>Error</td><td>Could not get disk information</td></tr>\n</table>\n");
        }
        return;
    }
    
    // Get size in GB
    double total_size = (double)(stat.f_blocks * stat.f_frsize) / (1024.0 * 1024.0 * 1024.0);
    double free_size = (double)(stat.f_bfree * stat.f_frsize) / (1024.0 * 1024.0 * 1024.0);
    double available_size = (double)(stat.f_bavail * stat.f_frsize) / (1024.0 * 1024.0 * 1024.0);
    double used_size = total_size - free_size;
    double usage_pct = (used_size / total_size) * 100.0;
    
    print_header(format, "Disk Information");
    
    if (format == FORMAT_TEXT) {
        printf("Total Size:     %.2f GB\n", total_size);
        printf("Free Size:      %.2f GB\n", free_size);
        printf("Available Size: %.2f GB\n", available_size);
        printf("Used Size:      %.2f GB\n", used_size);
        printf("Usage:          %.2f%%\n", usage_pct);
    } else if (format == FORMAT_JSON) {
        printf("    \"total_size\": %.2f,\n", total_size);
        printf("    \"free_size\": %.2f,\n", free_size);
        printf("    \"available_size\": %.2f,\n", available_size);
        printf("    \"used_size\": %.2f,\n", used_size);
        printf("    \"usage_pct\": %.2f\n  }\n", usage_pct);
    } else if (format == FORMAT_HTML) {
        printf("<tr><td>Total Size</td><td>%.2f GB</td></tr>\n", total_size);
        printf("<tr><td>Free Size</td><td>%.2f GB</td></tr>\n", free_size);
        printf("<tr><td>Available Size</td><td>%.2f GB</td></tr>\n", available_size);
        printf("<tr><td>Used Size</td><td>%.2f GB</td></tr>\n", used_size);
        printf("<tr><td>Usage</td><td>%.2f%%</td></tr>\n", usage_pct);
        printf("</table>\n");
    }
}